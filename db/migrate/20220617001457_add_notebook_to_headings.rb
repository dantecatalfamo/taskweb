class AddNotebookToHeadings < ActiveRecord::Migration[7.0]
  def up
    add_reference :headings, :notebook, null: true, foreign_key: true

    Notebook.create!(title: "Default") unless Notebook.any?
    notebook = Notebook.first
    Heading.find_each do |heading|
      heading.notebook = notebook
      heading.save!
    end

    change_column_null :headings, :notebook_id, false
  end

  def down
    remove_reference :headings, :notebook
  end
end
