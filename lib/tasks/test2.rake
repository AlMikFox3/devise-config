task :test2 => :environment do
	j = User.all.count
	k = j + 10
    for i in j+1..k do
    	@user = User.new()
    	@user.id = i
    	@user.name = Faker::Name.name
    	@user.email = Faker::Internet.email(@user.name)
    	@user.phone = Faker::PhoneNumber.cell_phone
    	@user.password = "12345678"
    	@user.password_confirmation = "12345678"
    	@user.address = Faker::Address.city
    	@user.save
    	puts "#{i}. #{@user.name} ---- #{@user.email} ---- #{@user.address}"
    end
end