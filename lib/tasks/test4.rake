task :test4 => :environment do
	@users = User.all
	lt = ["CL","SL","PL","ML","UL"]
	days = [6,6,10,0,0]
	@users.each do |user|
		for i in 0...5
			@ul = user.user_leaves.create(:user_id => user.id, :leave_type => lt[i], :leave_left => days[i], :leave_taken => 0)
			@ul.save
		end
	end
end