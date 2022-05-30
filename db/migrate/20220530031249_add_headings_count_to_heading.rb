class AddHeadingsCountToHeading < ActiveRecord::Migration[7.0]
  def change
    add_column :headings, :headings_count, :integer
  end
end
