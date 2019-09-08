# This class is used to store a users favorite stations.

class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :station


end
