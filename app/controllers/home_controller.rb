class HomeController < ApplicationController
  def home
    @notebooks = Notebook.all
    @agenda_dates = Heading.agenda_dates
  end
end
