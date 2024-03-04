class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?
  
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

  def toggle_admin
    
    User.update(params[:id], :admin=> params[:admin])

    #BROKEN - TO FIX
    redirect_to action: "super"
    
  end



end
