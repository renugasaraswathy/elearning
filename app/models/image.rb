class Image < ActiveRecord::Base
	 has_attached_file :picture,
	 :styles => {	 		
            :thumb => '100x100#'  
        },
        :url  => "/system/images/:id/:style/:basename.:extension",
        :path => "#{Rails.root}/public/system/images/:id/:style/:basename.:extension"
                
    validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
