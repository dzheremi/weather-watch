# This class is used to produce a JSON feed for a set of stations, when given a keyword.
# The class does not inherit from ActiveRecord, all attributes are destroyed when the web session completes.

class StationFeed

  # The hashed object which stores all stations.
  attr_accessor :stations


  # Given a keyword, this methods will produces the appropriate hash structure for the JSON API.
  def set_stations(stations)

    data = []

    stations.each do |s|
      data << {
          name: s.name,
          state: s.state.name,
          url: "/station/#{s.id}"
      }
    end

    self.stations = data

  end

end
