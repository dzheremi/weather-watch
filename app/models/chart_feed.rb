class ChartFeed

  attr_accessor :labels,
                :data

  def set(observations, reading_type)

    labels = []
    data = []

    observations.each do |o|
      o.readings.each do |r|
        if r.reading_type.id == reading_type.id
          labels << o.recording_time.to_s(:short)
          if reading_type.numeric
            data << r.numeric_value
          else
            data << r.string_value
          end
        end
      end
    end

    self.labels = labels.reverse
    self.data = data.reverse

  end

end
