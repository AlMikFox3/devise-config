#namespace :test do
  task :test1 => :environment do
    for i in 1..User.all.count do
    	@user = User.find(i)
    	puts @user.name
    end
  end
#end