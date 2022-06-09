class ReplaceHeadingStateStringWithReference < ActiveRecord::Migration[7.0]
  def up
    remove_column :headings, :status
    add_reference :headings, :heading_state, index: true
  end

  def down
    remove_reference :headings, :heading_state, index: true
    add_column :headings, :status, :string
  end
end
