# This class stores all registered users for the WeatherWatch website. Each user may have multiple Favorite
# objects, along with an assigned Timezone.

class User < ActiveRecord::Base

  attr_accessor :password

  belongs_to :timezone
  has_many :favorites

  before_save :encrypt_password
  after_save :clear_password

  validates :username, :presence => true, :uniqueness => true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :name, :presence => true
  validates :password, :confirmation => true, :on => :create
  validates :password, :length => 6..20, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
  validates :timezone_id, :presence => true

  def self.authenticate(username, password)
    user = User.where(username: username)
    if user.count > 0
      if user.first.encrypted_password == Digest::SHA1.hexdigest("#{user.first.salt}#{password}")
        user.first
      else
        false
      end
    else
      false
    end
  end

  def encrypt_password
    if self.password.present?
      self.salt= Digest::SHA1.hexdigest("#{self.email}#{self.name}#{Time.now}")
      self.encrypted_password = Digest::SHA1.hexdigest("#{self.salt}#{self.password}")
    end
  end

  def clear_password
    self.password = nil
  end

end
