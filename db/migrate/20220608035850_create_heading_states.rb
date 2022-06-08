class CreateHeadingStates < ActiveRecord::Migration[7.0]
  def change
    create_table :heading_states do |t|
      t.string :name
      t.boolean :done

      t.timestamps
    end
  end
end
