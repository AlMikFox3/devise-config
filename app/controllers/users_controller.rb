class UsersController < ApplicationController
  before_filter :verify_is_admin, :only => [:update, :destroy, :edit]
	def edit
  		@user = User.find(params[:id])
  		#redirect_to edit_user_registration_path(@u)
  end
 
 def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       redirect_to static_pages_show_path
	
     else
       render 'edit'
     end
   end

	def destroy
  	@u = User.find(params[:id])
  	#puts (@u.id)
  	@u.destroy
 
  	redirect_to static_pages_show_path
end

def block
    @u = User.find(params[:id])
    #puts (@u.id)
    @u.banned = true
 
    #redirect_to static_pages_show_path
end

	private
  def user_params
    params.require(:user).permit(:name,:date_of_birth,:address,:phone)
  end

  def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end

end
