# Each Reading is associated to a ReadingType. The ReadingType stores the name of the reading, and the
# appropriate metric used, for example:
#  - Apparent Temperature (Degree Celsius)
#  - Wind Speed (Kilometres Per Hour)
# It also is used to determine if a Reading contains a textual or numerical value.

class ReadingType < ActiveRecord::Base

  belongs_to :metric
  has_many :readings

  def safe_name
    self.name.gsub(' ','_').gsub('(','').gsub(')','').downcase
  end

  def abbreviation
    words = self.safe_name.split('_')
    abbreviation = ''
    words.each do |w|
      abbreviation << w[0].upcase
    end
    abbreviation
  end

end
