class AddPushoverUserKeyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pushover_user_key, :string
  end
end
