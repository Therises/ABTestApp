15.times do |u|
  Bookmark.create(name: "Bookmark #{u}", url: '#', user_id: 1)
end