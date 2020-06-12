class SessionsController < ApplicationController
  def new
  end

  def create
  	user_email =params[:session][:email]
  	user =User.find_by(email: user_email)
  	if user && user.authenticate(params[:session][:password])
  		redirect_to user_url(user)
  	else
  		flash[:danger]="Email or Password Incorrect."
  		render 'new'
  	end
  end
end
