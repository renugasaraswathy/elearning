class Image < ActiveRecord::Base
	 has_attached_file :picture,
	 :styles => {
            :thumb => '150x150#',
            :medium => '300x300>'            
        }
                
    validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
