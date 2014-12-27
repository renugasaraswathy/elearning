class TinymceAssetsController < ApplicationController
  def create
	geometry = Paperclip::Geometry.from_file params[:file]	

  puts "\n\n\n\n image params"  
  puts image_params
  puts image_params.methods
  puts image_params.inspect

    image=Image.new(:picture=>image_params[:file])
    #file=File.open(image_params)
    #image.picture=file
    #file.close
    image.save
    
    render json: {
      image: {
        url: image.picture.url
      }
    }, content_type: "text/html"
  end

  def image_params
    params.permit(:file)
  end

end