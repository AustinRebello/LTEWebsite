class AdminController < ApplicationController
  before_action :authenticate_user!
  
  def index

    @presidents = President.all
    @senates = Senate.all
    @governors = Governor.all
    @houses = House.all
    @miscs = Misc.all

  end

  def super
    @users = User.all
  end


end
