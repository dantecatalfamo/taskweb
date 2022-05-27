class CreateHeadings < ActiveRecord::Migration[7.0]
  def change
    create_table :headings do |t|
      t.string :title
      t.string :body
      t.string :status
      t.datetime :deadline
      t.datetime :scheduled

      t.timestamps
    end
  end
end
