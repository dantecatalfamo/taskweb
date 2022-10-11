class CreateHeadingProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :heading_properties do |t|
      t.references :heading, null: false, foreign_key: true
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
