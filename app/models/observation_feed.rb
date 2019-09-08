# This class is used to produce a JSON feed for a set of observations, when given a Station.
# The class does not inherit from ActiveRecord, all attributes are destroyed when the web session completes.

include ActionView::Helpers::DateHelper

class ObservationFeed

  # These are the hashed objects used to store observational data.
  attr_accessor :station,
                :observations


  # Given a Station, this method will produce the appropriate hash structure for the JSON API.
  def set_station(station)

    self.station = {
        state: station.state.name,
        station_name: station.name,
        station_id: station.id,
        station_lat: station.latitude,
        station_lon: station.longitude,
        station_tz: station.timezone.name
    }

  end

  # Given a group of observations, this method will produce the appropriate hash structure for the JSON API.
  def set_observations(observations)

    self.observations = []

    observations.each do |o|

      data = []

      readings = o.readings

      readings.each do |r|

        if r.reading_type.numeric
          data << {
              name: r.reading_type.name,
              safe_name: r.reading_type.safe_name,
              value: r.numeric_value,
              unit_abbr: r.reading_type.metric.abbreviation,
              unit_full: r.reading_type.metric.name
          }
        else
          data << {
              name: r.reading_type.name,
              safe_name: r.reading_type.safe_name,
              value: r.string_value,
              unit: nil
          }
        end

      end

      self.observations << {
          time: o.recording_time,
          updated_ago: "updated #{time_ago_in_words(o.recording_time)} ago",
          readings: data}

    end

  end


end
