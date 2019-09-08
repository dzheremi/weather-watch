# Stores all states and territories of Australia.

class State < ActiveRecord::Base

  has_many :stations

  # Returns the URL required to capture all stations for this state.
  def url
    "http://www.bom.gov.au/#{self.abbreviation}/observations/#{self.abbreviation}all.shtml"
  end

end
