class StaticPagesController < ApplicationController
	 def home
	 	
    end

    def show
    	@users = User.paginate(:page => params[:page], per_page: 10)
    end

end

