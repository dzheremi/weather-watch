module SiteHelper

  def current_conditions(station, mini = false)
    unless station.nil?
      unless station.observations.count == 0
        data = []
        station.latest_observations.first.ordered_readings.each do |r|
          if mini
            unless Global::MINI_READING_TYPES.include?(r.reading_type.name)
              next
            end
          end
          icon = Rails.application.assets.find_asset "weather_icons/#{r.reading_type.safe_name}.png"
          data << %{
        <tr>
          <td style="text-align: center;">#{image_tag "weather_icons/#{r.reading_type.safe_name}.png" if icon}</td>
          <td>#{r.reading_type.name}</td>
          <td>
            <div id="#{station.id}_#{r.reading_type.safe_name}">
              #{r.numeric_value if r.reading_type.numeric}
              #{r.string_value unless r.reading_type.numeric}
              #{r.reading_type.metric.abbreviation if r.reading_type.numeric}
            </div>
          </td>
        </tr>
      }
        end
        render partial: 'site/current_conditions', locals: {station: station, data: data}
      end
    end
  end

  def station_map(station)
    render partial: 'site/station_map', locals: {station: station}
  end

  def station_chart(station)
    render partial: 'site/station_chart', locals: {station: station}
  end

  def observation_table(station)
    render partial: 'site/observations_table', locals: {station: station}
  end

  def statistics_table(station)
    render partial: 'site/statistics_table', locals: {station: station}
  end

  def map
    render partial: 'site/map'
  end

  def toggle_favorite(station)
    if @current_user
      on = false
      @current_user.favorites.each do |f|
        on = true if f.station.id == station.id
      end
      render partial: 'site/toggle_favorite', locals: {station: station, on: on}
    end
  end
  
end
