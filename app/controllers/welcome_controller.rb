class WelcomeController < ApplicationController
  def index
  end

  def dashboard
    user_count = User.all.count
    render :dashboard, :locals => { :user_count => user_count }
  end
end
