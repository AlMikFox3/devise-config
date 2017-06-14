class StaticPagesController < ApplicationController
	before_filter :verify_is_admin, :only => [:show]
	 def home
	 	
    end

    def show
    	#@users = User.paginate(:page => params[:page], per_page: 10)
    	@users = User.all
    end

    private

	def verify_is_admin
  		(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
	end

end

