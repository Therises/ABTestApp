class Bookmark < ApplicationRecord

  belongs_to :user
  mount_uploader :thumbnail, ThumbnailUploader

  def self.search(q, id)
    if q
      where(user_id: id)
      .where("name ILIKE ?", "%#{q}%")
      .or(where("url ILIKE ?", "%#{q}%"))
    else
      where(user_id: id)
    end
  end

  def get_webshot
    webshot = Webshot::Screenshot.instance
    webshot.capture self.url, self.name + '.png', width: 250, height: 141
    self.thumbnail = Rails.root.join(self.name + '.png').open
    self.save
  end



  handle_asynchronously :get_webshot
end