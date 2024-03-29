# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      #handle_remember_cookie! new_cookie_flag
      redirect_url = '/consultant/overview'
      redirect_url = '/admin/users' if self.current_user.is_admin?
      
      redirect_back_or_default(redirect_url)
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/login')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Please enter your username and password."
    flash[:error] = "Couldn't log you in as '#{params[:login]}'" if params[:login] != ''
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
