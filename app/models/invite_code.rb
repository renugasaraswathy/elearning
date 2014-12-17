class InviteCode < ActiveRecord::Base
	def decrement
    self.max_registrations -= 1
    self.save
  end
end
