class Category < ActiveRecord::Base
	extend FriendlyId
	attr_accessor :sub_categories_create
  	friendly_id :name, use: :slugged  	
	has_many :sub_categories,:class_name=>"Category",:foreign_key=>"parent_id"
	belongs_to :parent,:class_name=>'Category'
	belongs_to :user
	has_many :posts
	validates :name,:presence=>true


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



	def self.parent_categories
		Category.where(:parent_id=>nil)
	end

end
