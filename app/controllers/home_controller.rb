class HomeController < ApplicationController
  def home
    redirect_to notebooks_path if logged_in?
  end
end
