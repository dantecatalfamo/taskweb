require 'securerandom'

class AddOrgIdToHeadings < ActiveRecord::Migration[7.0]
  def up
    add_column :headings, :org_id, :string
    
    Heading.find_each do |heading|
      heading.org_id = SecureRandom.uuid
      heading.save!
    end

    change_column_null :headings, :org_id, false
    add_index :headings, :org_id
  end

  def down
    remove_column :headings, :org_id
  end
end
