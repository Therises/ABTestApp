class Bookmark < ApplicationRecord
  include PgSearch

  belongs_to :user
  mount_uploader :thumbnail, ThumbnailUploader

  pg_search_scope :search, against: [:name, :url], using: [:tsearch, :trigram, :dmetaphone]

  def get_webshot
    webshot = Webshot::Screenshot.instance
    webshot.capture self.url, self.name + '.png', width: 250, height: 141
    self.thumbnail = Rails.root.join(self.name + '.png').open
    self.save
  end
  handle_asynchronously :get_webshot
end