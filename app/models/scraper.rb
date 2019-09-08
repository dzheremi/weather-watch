# The Scraper class contains all the methods required to obtain data from the BOM website.

class Scraper

  require 'open-uri'

  # Used to log the activity of the scraper methods.
  def scraper_logger

    @@scraper_logger ||= Logger.new("#{Rails.root}/log/scraper.log")

  end


  # Updates all stations from BOM website.
  def update_stations

    State.all.each do |s|
      fetch_stations(s)
    end

  end

  # Updates all weather observations from BOM data feeds.
  def update_observations

    State.all.each do |s|
      fork do
        Station.where(state_id: s.id).each do |s|
          fetch_observations(s)
        end
      end
    end

  end


  # Retrieves a list of the URLS for each weather station given a State.
  # Each url is then passed to the extract_station method.
  def fetch_stations(state)

    scraper_logger.info("Fetching stations for #{state.name}")

    doc = Nokogiri::HTML(open(state.url))
    doc.css('a').each do |s|

      Global::OBSERVATION_PRODUCT_CODE.each do |c|
        if s.attr('href').include?(c) and s.attr('href').include?(state.product_group)
          extract_station(s.attr('href'), state)
        end
      end

    end

    scraper_logger.info("Completed fetching stations for #{state.name}")

  end


  # Creates a new, or updates an existing, Station given it's URL and the State to which it belongs.
  def extract_station(url, state)

    id, json_url = nil

    doc = Nokogiri::HTML(open("#{Global::BOM_BASE_URL}#{url}"))
    doc.css('a').each do |l|

      if l.attr('href').include?('json')
        json_url = l.attr('href')
        id = l.attr('href').split('.')
        id = id[1]
      end

    end

    begin
      station = Station.find(id)
      scraper_logger.info("Updating existing station #{id}")

    rescue
      station = Station.new
      station.id = id
      scraper_logger.info("Creating new station #{id}")

    end

    begin
      station.state = state

      name = doc.css('h1').first
      station.name = name.text.gsub('Latest Weather Observations for ','')

      station.station_url = "#{Global::BOM_BASE_URL}#{url}"
      station.json_url = "#{Global::BOM_BASE_URL}#{json_url}"

      json = extract_observations(station.json_url)
      station.latitude = json['observations']['data'].first['lat']
      station.longitude = json['observations']['data'].first['lon']

      tz = Timezone.where(abbreviation: json['observations']['header'].first['time_zone'])
      if tz.size > 0
        station.timezone = tz.first
        station.save

        scraper_logger.info("#{station.id} - #{station.name} has been saved")

      else
        scraper_logger.warn("#{station.id} - #{station.name} could not be saved due to unknown TZ (#{json['observations']['header'].first['time_zone']})")

      end

    rescue
      scraper_logger.warn("#{station.id} - #{station.name} could not be saved due missing data in JSON file)")

    end
    
  end


  # Will retrieve all new observations given a Station.
  def fetch_observations(station)

    scraper_logger.info("Fetching latest weather observations for #{station.id} - #{station.name}")

    new = 0

    json = extract_observations(station.json_url)
    json['observations']['data'].each do |o|

      Time.zone = 'UTC'
      recording_time = Time.zone.parse("#{o['aifstime_utc']}Z")

      unless Observation.already_exists?(station, recording_time)
        observation = Observation.new
        observation.station = station
        observation.recording_time = recording_time
        observation.save

        parse_readings(o, observation)

        new += 1

      end

    end

    scraper_logger.info("Added #{new} new observations")

  end


  # Returns the JSON object from a stations observation.
  def extract_observations(url)

    JSON.load(open(url))

  end

  # Given a JSON feed containing a group of BOM observations, along with an Observation, this method will
  # create all necessary Reading records based on ReadingType records.
  def parse_readings(json, observation)

    ReadingType.all.each do |r|

      reading = Reading.new
      reading.observation = observation
      reading.reading_type = r

      unless json[r.bom_field_name].nil?
        if r.numeric
          reading.numeric_value = json[r.bom_field_name].to_d unless json[r.bom_field_name] == '-'
        else
          reading.string_value = json[r.bom_field_name] unless json[r.bom_field_name] == '-'
        end
      end

      reading.save

    end

  end


end