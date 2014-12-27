class Post < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: :slugged
  	validate :title,:description,:presence=>true
  	validate :title,:length=>{:minimum=>2}
  	validate :description,:length=>{:minimum=>10}
  	attr_accessor :category_slug  	
  	belongs_to :category
	before_save :set_category,:validate_title_and_description

   scope :find_threads_on_category, ->(category_id) { where(:category_id => category_id)}
   scope :published,->{ where(:published=>1)}
   scope :descending,->{order("created_at DESC")}
  	def set_category
		self.category=Category.find_by_slug(self.category_slug) if self.category_slug
	end

  def validate_title_and_description    
    self.errors.add(:title,"is blank") if self.title==""
    self.errors.add(:description,"is blank") if self.description==""
  end


  def short_description
    if self.description.length>300
      self.description[0..300]+"..."
    else
      self.description
    end
  end

end
