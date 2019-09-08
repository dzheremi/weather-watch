# Stores information for each BOM weather station for all states and territories of Australia.
class Station < ActiveRecord::Base

  belongs_to :state
  belongs_to :timezone
  has_many :observations, :dependent => :destroy

  def self.find_by_name(keyword)
    self.where("LOWER(name) LIKE '%#{keyword.gsub(' ','%').downcase}%'")
  end

  def self.records
    records = []
    Global::RECORDS_READING_TYPES.each do |r|
      stations = []
      metric = nil
      if r[:max]
        max = Reading.joins(:reading_type).where("reading_types.name = '#{r[:reading_name]}'").maximum(:numeric_value)
        Reading.where(numeric_value: max).joins(:reading_type).where("reading_types.name = '#{r[:reading_name]}'").each do |s|
          stations << {id: s.observation.station.id, time: s.observation.recording_time}
          metric = s.reading_type.metric.abbreviation
        end
        stations.uniq! {|s| s[:id]}
        records << {name: r[:name], value: "#{max} #{metric}", stations: stations}
      else
        min = Reading.joins(:reading_type).where("reading_types.name = '#{r[:reading_name]}'").minimum(:numeric_value)
        Reading.where(numeric_value: min).joins(:reading_type).where("reading_types.name = '#{r[:reading_name]}'").each do |s|
          stations << {id: s.observation.station.id, time: s.observation.recording_time}
          metric = s.reading_type.metric.abbreviation
        end
        stations.uniq! {|s| s[:id]}
        records << {name: r[:name], value: "#{min} #{metric}", stations: stations}
      end
    end
    records
  end

  # Retrieves the latest Observation for this station. Returns False if no observations are available.
  def latest_observations(number = 1)

    observations = self.observations.order(recording_time: :desc).limit(number)
    if observations.count > 0
      observations
    else
      false
    end

  end

  def oldest_observations(number = 1)

    observations = self.observations.order(recording_time: :asc).limit(number)
    if observations.count > 0
      observations
    else
      false
    end

  end

  def last_updated

    latest = self.latest_observations
    if latest
      latest.first.recording_time
    else
      false
    end

  end

  def oldest_update

    oldest = self.oldest_observations
    if oldest
      oldest.first.recording_time
    else
      false
    end

  end

  def observation_feed(number = 10)

    feed = ObservationFeed.new
    feed.set_station(self)
    feed.set_observations(self.latest_observations(number))
    feed

  end

  def chart_feed(reading_type, number = 20)

    feed = ChartFeed.new
    reading_type = ReadingType.where(name: reading_type).first
    feed.set(self.latest_observations(number), reading_type)
    feed

  end

  def average_update_time
    last = nil
    sum = 0
    total = 0
    self.observations.order(recording_time: :desc).limit(Global::AVERAGE_OBSERVATIONS_LIMIT + 1).each do |o|
      unless last
        last = o.recording_time
        next
      end
      sum += last - o.recording_time
      total += 1
      last = o.recording_time
    end
    (sum / total).round
  end

end
