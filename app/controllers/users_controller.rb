class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user ,only: [:edit, :update]
  before_action :admin_user ,only: [:destroy]
  def new
  	@user = User.new
  end

  def index
    @users=User.paginate(page: params[:page] , per_page: 10)
  end

  def show
  	user_id=params[:id]
  	@user=User.find(user_id)
    @microposts=@user.microposts
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

  def edit
    @user =User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile Successfully updated"
      redirect_to user_url(@user)
    else 
      flash[:danger] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="Successfully deleted"
    redirect_to users_url
  end

  private
   def user_params
   	params.require(:user).permit(:name, :email , :password, :password_confirmation, :image)
   end
   def correct_user
    @user =User.find(params[:id])
    redirect_to(root_url) unless @user ==current_user
    end

    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
