# An observation contains multiple Reading entities - the observation class records the Station and recording
# time obtained from the BOM data feed. It is used to group readings together and to ensure that existing readings
# are not duplicated.

class Observation < ActiveRecord::Base

  belongs_to :station
  has_many :readings, :dependent => :destroy


  # Determines if a specific observation already exists in our database.
  def self.already_exists?(station, recording_time)

    existing = self.where(station: station).where(recording_time: recording_time)
    existing.size > 0

  end

  def self.oldest_observation(number = 1)

    observations = self.all.order(recording_time: :asc).limit(number)

    if observations.count > 0
      observations

    else
      false

    end

  end

  def ordered_readings

    self.readings.joins(:reading_type).order('display_order ASC')

  end

end
