class Post < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: :slugged
  	validate :title,:description,:presence=>true
  	validate :title,:length=>{:minimum=>2}
  	validate :description,:length=>{:minimum=>10}
  	attr_accessor :category_slug  	
  	belongs_to :category
	before_save :set_category

  	def set_category
		self.category=Category.find_by_slug(self.category_slug) if self.category_slug
	end

  def short_description
    if self.description.length>300
      self.description[0..300]+"..."
    else
      self.description
    end
  end

end
