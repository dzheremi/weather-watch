# Each Station and User is assigned a Timezone - Observations are stored in the stations local timezone, and
# users may nominate their own local timezone.
# This class records the timezone name, its abbreviation, and its location, for example:
# - Eastern Daylight Time - EDT - Melbourne
# - Eastern Standard Time - EST - Brisbane
# - Western Standard Time - WST - Perth
# The location stored in this object is used only select the appropriate ActiveSupport::TimeZone object.

class Timezone < ActiveRecord::Base

  has_many :stations
  has_many :users

end
