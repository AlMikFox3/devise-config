class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  #layout 'mailer'

  def welcome_email(leave)
      @user = User.find(leave.user_id)
    @admint = User.where(:admin => true)
    @adminp =@admint[0]
    @url  = 'http://localhost:3000/leaves'
    mail(to: @adminp.email, subject: 'applied for leave')
    mail(to: @user.manager_email, subject: 'applied for leave')
  end

  def approve_user(user)
    @user = user
    @admint = User.where(:admin => true)
    @adminp =@admint[0]
    #@url  = 'http://example.com/login'
    mail(to: @adminp.email, subject: 'user approval')
  end

  def approve_leave_mail(leave)
  	@leave = leave
  	@u = User.find(leave.user_id)
  	@admint = User.where(:admin => true)
    @adminp =@admint[0]
    mail(to: @u.email, subject: 'Leave Approved')
  end

end