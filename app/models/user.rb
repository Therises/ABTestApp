class User < ApplicationRecord
  before_create :generate_token
  has_many :bookmarks


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def generate_token
    begin
      self[:unique_token] = SecureRandom.urlsafe_base64
    end while User.exists?(unique_token: self[:unique_token])
  end
  
end
