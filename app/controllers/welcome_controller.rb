class WelcomeController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter, :except => [:welcome]

  def index
    if session[:cas_user]
      netid = session[:cas_user]
      @user = User.find_by_netid netid
      @user = User.get_user netid if not @user
      # Not found in directory or database
      if not @user
        flash_now[:error] = "Login failure :-/"
        redirect_to '/welcome'
        return
      end
      render :layout => 'dynamic'
      return
    end
    redirect_to '/welcome'
  end

  def welcome
    session[:cas_user] = nil
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
  
  def about
  end
end
