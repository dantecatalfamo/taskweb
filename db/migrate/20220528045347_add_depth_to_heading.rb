class AddDepthToHeading < ActiveRecord::Migration[7.0]
  def change
    add_column :headings, :depth, :integer
  end
end
