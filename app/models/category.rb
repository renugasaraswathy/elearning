class Category < ActiveRecord::Base
	extend FriendlyId
	attr_accessor :sub_categories_create
  	friendly_id :name, use: :slugged  	
	has_many :sub_categories,:class_name=>"Category",:foreign_key=>"parent_id"
	belongs_to :parent,:class_name=>'Category'
	belongs_to :user
	has_many :posts
	validates :name,:presence=>true
	before_save :validate_name

	scope :parent_categories,->{where(:parent_id=>nil)}
	scope :non_parent_categories,->{where("parent_id is not null")}

	def sub_categories_create=(value)
		value[:name].each do |n|
			self.sub_categories.new(:name=>n,:user=>self.user)
		end
	end	

	def sub_categories_update=(value)		
		i=0
		value[:slug].each do |n|
			sub_category=self.sub_categories.find_by_slug(n)
			sub_category.update_attribute(:name,value[:name][i])
			i+=1
		end
	end

	def posts_count
		if self.parent_id==nil
			count=0
			self.sub_categories.each do |sub_category|
				count+=sub_category.posts_count				
			end
		else
			count=self.posts.count
		end
		return count
	end

	def posts
		if self.parent_id
			Post.find_threads_on_category(self.id).published.descending
		else
			Post.find_threads_on_category(self.sub_categories.collect(&:id)).published.descending
		end
	end

	def validate_name
    self.errors.add(:name,"is blank") if self.name==""    
  end

  def self.popular_categories
  	categories_count={}
  	Category.all.non_parent_categories.each do |cat|
  		categories_count[cat.id]=cat.posts_count
  	end
  	return Hash[categories_count.sort_by{ |_, v| -v }[0..4]]
  end
	

end
