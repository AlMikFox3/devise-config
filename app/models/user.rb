class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable



  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :image, ImageUploader

  has_many :leaves
  has_many :user_leaves

  after_create :send_admin_mail, :create_ul

  def send_admin_mail
  	LeaveMailer.approve_user(self).deliver
  end

  def create_ul
  	@user = self
  	lt = ["CL","SL","PL","ML","UL"]
	days = [6,6,10,0,0]
	
		for i in 0...5
			@ul = @user.user_leaves.create(:user_id => @user.id, :leave_type => lt[i], :leave_left => days[i], :leave_taken => 0)
			@ul.save
		end
  end
end

