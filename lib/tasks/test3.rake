task :test3 => :environment do
	
    for i in 5..14 do
    	@user = User.find(i)
    	@user.destroy
    	#puts "#{i}. #{@user.name} ---- #{@user.email} ---- #{@user.address}"
    end
  end