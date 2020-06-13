class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	user_id=params[:id]
  	@user=User.find(user_id)
  end

  def create
  	@user =User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to sample App!"
  		redirect_to user_url(@user)
  	else 
  		render 'new'
  	end

  end 

  private
   def user_params
   	params.require(:user).permit(:name, :email , :password, :password_confirmation)
   end
end
