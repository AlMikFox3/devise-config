class StaticPagesController < ApplicationController
	 def home
	 	
    end

    def show
    	@users = User.all
    end

end

