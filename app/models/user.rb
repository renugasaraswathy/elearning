class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :generate_custom_slug, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :sign_up_code       

  has_many :categories

  validate :for_proper_invite_code,:on=>:create
  after_create :decrement_invite_code
  

   def generate_custom_slug
    "#{first_name}-#{last_name}"
   end 

  def for_proper_invite_code
    if self.sign_up_code and not self.sign_up_code.empty?
      @ic = InviteCode.find_by_code(self.sign_up_code)
      if @ic
        if @ic.max_registrations.zero?
          self.errors.add(:sign_up_code, "Invite Code Expired")
        end
      else
        self.errors.add(:sign_up_code, "Invalid Invite Code")
      end
    else
      self.errors.add(:sign_up_code, "Invite Code is empty")
    end
  end
     
  def decrement_invite_code
    @ic.decrement if @ic
  end

  def full_name
    if self.first_name 
    self.first_name+" "+self.last_name
  else
    self.email
  end
  end

end
