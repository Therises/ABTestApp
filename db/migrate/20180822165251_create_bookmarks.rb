class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.string :url
      t.string :thumbnail
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
