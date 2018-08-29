class AddUniqueTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :unique_token, :string
  end
end
