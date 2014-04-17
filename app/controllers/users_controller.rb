class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    new_and_create_action_restriction
  	@user = User.new
  end
  
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create
    new_and_create_action_restriction
  	@user = User.new(user_params)
	 
   if @user.save
     sign_in @user
		  flash[:success] = "Welcome to the Sample Application!"
		  redirect_to @user
    else
		  render 'new'
	   end  	
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    # Exer 9.6:9 TODO: Modify the destroy action to prevent admin users from destroying themselves.
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url    
  end


	private
      # Add the admin attribute to the permitted parameters first { Exercise 9.6:1 #ToDo to check the corresponding test fail}
  		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)  	
  		end

      # Before filters

      # signed_in_user moved to sessions_helper.rb as both microposts controller and users_controller needs access to this.
      # def signed_in_user
      #   unless signed_in?
      #     store_location
      #     redirect_to signin_url, notice: "Please Sign in." unless signed_in?  
      #   end        
      # end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end

      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end

      # new_and_create_action_restriction to restrict access to new and create actions if the user is already signed in.
      def new_and_create_action_restriction
        redirect_to(root_url) unless !current_user
      end

end
