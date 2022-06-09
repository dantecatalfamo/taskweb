class AddColorColumnToHeadingStates < ActiveRecord::Migration[7.0]
  def change
    add_column :heading_states, :color, :string
  end
end
