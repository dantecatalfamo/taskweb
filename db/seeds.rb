# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(username: 'admin', password: '1')
HeadingState.create(
  [
    { name: 'TODO', done: false, color: '#e01b24', user: User.first },
    { name: 'NEXT', done: false, color: '#1c71d8', user: User.first },
    { name: 'WIP',  done: false, color: '#e01b24', user: User.first },
    { name: 'DONE', done: true,  color: '#26a269', user: User.first }
  ]
)
Notebook.create(title: "Notebook1")
Heading.create(notebook: Notebook.first, title: "Heading 1")
