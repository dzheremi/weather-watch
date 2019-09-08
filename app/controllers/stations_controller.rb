# API controller for access an index of stations.

class StationsController < ApplicationController
  before_filter :authorised_user
  around_filter :set_time_zone

  def search
    stations = Station.find_by_name(params[:keyword])
    feed = StationFeed.new
    feed.set_stations(stations)
    render json: feed
  end
  
end
