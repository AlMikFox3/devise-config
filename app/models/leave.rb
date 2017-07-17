class Leave < ActiveRecord::Base
	belongs_to :user
	validate :duration_contains_sunday
	validate :exceeds_leave_balance
	validate :prior_1_day
	validate :sick_leave
	validate :priv_leave
	validate :from_to
	validate :valid_lt
	validate :financial_year
	validate :before_six

	
	def before_six
		d = Date.today
		dm = d.month
		fd = self.from_date
		fdm = fd.month
		if (self.from_date < self.to_date)
			if dm < fdm
				r = fdm - dm
				if r > 6
					self.errors.add(:duration, "Can't Apply before 6 months")
				end
			else
				if fdm == 1 && dm <7
					self.errors.add(:duration, "Can't Apply before 6 months")
				end
				if fdm == 2 && dm <8
					self.errors.add(:duration, "Can't Apply before 6 months")
				end
				if fdm == 3 && dm <9
					self.errors.add(:duration, "Can't Apply before 6 months")
				end
			end
		end

	end

	def start_time
        self.from_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

	def valid_lt
		if self.ltype == "chose leave-type"
			self.errors.add(:ltype, "Choose a valid Leave Type")
		end

	end

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
		if(self.ltype != "chose leave-type" )
		 @ul = UserLeave.where(:user_id => self.user_id, :leave_type => self.ltype, :fin_year => self.fin_year)
		#@ul = UserLeave.where(:leave_type => self.ltype, :user_id => self.user_id)
		if @ul.any?
		@ul1 = @ul[0]
		d1 = self.duration.to_i
		d2 = @ul1.leave_left.to_i
		if d2 < d1
			self.errors.add(:duration, "exceeds leave balance by #{d1-d2} days")
		end
	end
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
				if (m_frm - m_last < 2 || self.duration.to_i > 1) && (self.fin_year != @lv.fin_year)
					self.errors.add(:duration, "Only 1 SL is allowed in 2 months")
				end
			end
		end
	end

	def priv_leave
		if self.ltype == 'PL'
			@u = User.find(self.user_id)
			jd = @u.joining_date
			td = Date.today
			month = (td.year * 12 + td.month) - (jd.year * 12 + jd.month)
			month.divmod(12)
			if(month < 12)
				self.errors.add(:duration, "PL applicable after 1 year of service only")
			end

		end
	end

	def from_to
		if (self.from_date >= self.to_date)
			self.errors.add(:duration, "Invalid From and To Dates")
		end
	end

	def financial_year
    	@ulf = UserLeave.where(:user_id => self.user_id, :fin_year => self.fin_year, :leave_type => self.ltype)
    	if !(@ulf.any?)
    		self.errors.add(:fin_year, "Leave not allocated")
    	end
  	end

end
