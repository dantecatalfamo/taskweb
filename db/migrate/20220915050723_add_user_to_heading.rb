class AddUserToHeading < ActiveRecord::Migration[7.0]
  def change
    add_reference :headings, :user, null: false, foreign_key: true
  end
end
