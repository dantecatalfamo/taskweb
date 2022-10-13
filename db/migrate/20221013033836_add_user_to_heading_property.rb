class AddUserToHeadingProperty < ActiveRecord::Migration[7.0]
  def up
    add_reference :heading_properties, :user, foreign_key: true # nullable
    HeadingProperty.find_each do |property|
      property.user = property.heading.user
      property.save!
    end
    change_column_null :heading_properties, :user_id, false
  end

  def down
    remove_reference :heading_properties, :user
  end
end
