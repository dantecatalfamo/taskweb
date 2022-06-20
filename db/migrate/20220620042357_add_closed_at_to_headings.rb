class AddClosedAtToHeadings < ActiveRecord::Migration[7.0]
  def change
    add_column :headings, :closed_at, :datetime
  end
end
