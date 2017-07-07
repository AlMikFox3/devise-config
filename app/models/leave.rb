class Leave < ActiveRecord::Base
	belongs_to :user
	validate :duration_contains_sunday
	validate :exceeds_leave_balance
	validate :prior_1_day
	validate :sick_leave
	def duration_contains_sunday
		@lv = self
		from = @lv.from_date
		to = @lv.to_date
		@ul = UserLeave.where(:user_id => self.user_id, :leave_type => self.ltype)
		@ul1 = @ul[0]
		a = self.duration.to_i
		
		for i in from..to
			if i.sunday?
				self.errors.add(:duration, "Contains a Sunday")


				break
			end
		end
	end

	def exceeds_leave_balance
		 @ul = UserLeave.where(:user_id => self.user_id, :leave_type => self.ltype)
		#@ul = UserLeave.where(:leave_type => self.ltype, :user_id => self.user_id)
		@ul1 = @ul[0]
		d1 = self.duration.to_i
		d2 = @ul1.leave_left.to_i
		if d2 < d1
			self.errors.add(:duration, "exceeds leave balance by #{d1-d2} days")
		end
		
	end

	def prior_1_day
		d1 = self.from_date
		d2 = Date.today
		if ((d1-d2).to_i <= 1)
			self.errors.add(:from_date, "Leave should be applied before 1 day")
		end
	end

	def sick_leave
		if self.ltype == 'SL'
			@u = User.find(self.user_id)
			@leaves = Leave.where(:user_id => @u.id, :ltype => "SL", :approval => true)
			sorted = @leaves.sort_by &:created_at
			if sorted.any?
				@lv = sorted.last
				from_d = self.from_date
				m_frm = from_date.month
				m_last = @lv.created_at.month
				if m_frm - m_last < 2 || self.duration.to_i > 1
					self.errors.add(:duration, "Only 1 SL is allowed in 2 months")
				end
			end
		end
	end

end
