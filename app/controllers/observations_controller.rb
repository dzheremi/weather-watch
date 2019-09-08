# API controller for accessing observational data.

class ObservationsController < ApplicationController
  before_filter :authorised_user
  around_filter :set_time_zone

  # Method returns a JSON file based on the ObservationFeed class.
  # Can be called with one of the following URLs:
  # - /observations/{{station_id}} - Returns the last 10 observations.
  # - /observations/{{station_id}}/{{limit}} - Returns the specified number of observations.
  # - /observations/{{station_id}}/all - Returns all observations.
  def show

    station = Station.find(params[:id])

    if params[:readings].nil?
      render json: station.observation_feed

    else

      if params[:readings] == 'all'
        render json: station.observation_feed(nil)

      else
        render json: station.observation_feed(params[:readings])

      end

    end

  end

  def observation_table

    station = Station.find(params[:id])

    if params[:readings].nil?
      render partial: 'observations/table', locals: {observations: station.latest_observations(Global::OBSERVATION_TABLE_DEFAULT_SIZE)}

    else
      render partial: 'observations/table', locals: {observations: station.latest_observations(params[:readings])}

    end

  end

  def statistics_table

    station = Station.find(params[:id])
    observation_ids = []
    statistics = []

    station.observations.select(:id).each do |o|
      observation_ids << o.id
    end

    Global::STATISTICS_READING_TYPES.each do |t|
      min, max, avg = nil
      min = Reading.where(observation_id: observation_ids).joins(:reading_type).where("reading_types.name = '#{t[:name]}'").minimum(:numeric_value) if t[:min]
      max = Reading.where(observation_id: observation_ids).joins(:reading_type).where("reading_types.name = '#{t[:name]}'").maximum(:numeric_value) if t[:max]
      avg = Reading.where(observation_id: observation_ids).joins(:reading_type).where("reading_types.name = '#{t[:name]}'").average(:numeric_value) if t[:avg]
      unit = ReadingType.where(name: t[:name]).first.metric.abbreviation
      statistics << {name: t[:name], unit: unit, min: min, max: max, avg: avg}
    end

    render partial: 'observations/statistics', locals: {statistics: statistics, observations: observation_ids.count, oldest: station.oldest_update}

  end

  def temperature_chart

    station = Station.find(params[:id])

    if params[:readings].nil?
      render json: station.chart_feed(Global::TEMP_FIELD_NAME)

    else
      render json: station.chart_feed(Global::TEMP_FIELD_NAME, params[:readings])

    end

  end

  def pressure_chart

    station = Station.find(params[:id])

    if params[:readings].nil?
      render json: station.chart_feed(Global::PRES_FIELD_NAME)

    else
      render json: station.chart_feed(Global::PRES_FIELD_NAME, params[:readings])

    end

  end

  def humidity_chart

    station = Station.find(params[:id])

    if params[:readings].nil?
      render json: station.chart_feed(Global::HUMI_FIELD_NAME)

    else
      render json: station.chart_feed(Global::HUMI_FIELD_NAME, params[:readings])

    end

  end

end
