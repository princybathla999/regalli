class HomeController < ApplicationController
  def index
  end

  def history
  end

  def log
  end
  def user
  @user= User.all
  end
end
