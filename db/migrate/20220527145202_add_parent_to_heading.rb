class AddParentToHeading < ActiveRecord::Migration[7.0]
  def change
    add_reference :headings, :parent, index: true
  end
end
