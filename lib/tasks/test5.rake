task :test5 => :environment do
	@users = User.all
	lt = ["CL","SL","PL","ML","UL"]
	days = [6,6,10,0,0]
	fin_y = "2018-19"
	@users.each do |user|
		for i in 0...5
			@ul = user.user_leaves.create(:user_id => user.id, :leave_type => lt[i], :leave_left => days[i], :leave_taken => 0, :fin_year => fin_y)
			@ul.save
		end
	end
end