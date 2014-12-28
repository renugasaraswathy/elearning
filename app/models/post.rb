class Post < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: :slugged
  	validate :title,:description,:presence=>true
  	validate :title,:length=>{:minimum=>2}
  	validate :description,:length=>{:minimum=>10}
  	attr_accessor :category_slug  	
  	belongs_to :category
    belongs_to :user
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
    desc=ActionController::Base.helpers.strip_tags(self.description)        
    if desc.length>300
      desc=desc[0..300]+"..."
    else
      desc
    end
    return desc
  end

  def image_in_description
    doc = Nokogiri::HTML( self.description )
    img_srcs = doc.css('img').map{ |i| i['src'] } # Array of strings
    if !img_srcs.empty?
      img_srcs.first.gsub(/original/, 'thumb')
    end
  end  

end
