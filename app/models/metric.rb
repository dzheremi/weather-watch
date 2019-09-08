# Readings are associated to metrics. Example metrics can be:
#  - Celsius (°C)
#  - Millimeters (mm)
#  - Hectopascals (hPa)

class Metric < ActiveRecord::Base

  has_many :reading_types


end
