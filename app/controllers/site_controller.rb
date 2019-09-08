class SiteController < ApplicationController
  before_filter :authorised_user
  around_filter :set_time_zone

  def index
    if @current_user
      redirect_to :action => :favorites
    else
      redirect_to :action => :map
    end
  end

  def map
    @containerless = true
  end

  def favorites
    if @current_user
      @favorites = @current_user.favorites
    else
      redirect_to :action => :index
    end
  end

  def capitals
    @capitals = Station.where(:capital => true).order(name: :asc)
  end

  def state
    @state = State.where(abbreviation: params[:state]).first
    @stations = @state.stations.order(name: :asc)
  end

  def records
    @records = Station.records
  end

  def sub_map
    @stations = Station.all
    render layout: 'plain'
  end

  def station
    @station = Station.find(params[:id])
  end

  def station_map
    @station = Station.find(params[:id])
    render layout: 'plain'
  end

  def station_chart
    @station = Station.find(params[:id])
    render layout: 'plain'
  end

end
