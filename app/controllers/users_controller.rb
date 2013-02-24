class UsersController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  
  respond_to :json

  def me
    user = User.find_by_netid session[:cas_user]
    redirect_to '/' if not user
    respond_with user
  end
  
end
