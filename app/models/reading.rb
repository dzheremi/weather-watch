# Each observation contains multiple readings (i.e. Temperature, Humidity, etc.).
# Each reading is assigned to a ReadingType - which determines if the data is numerical or textual, and
# associates it to a Metric.

class Reading < ActiveRecord::Base

  belongs_to :observation
  belongs_to :reading_type


end
