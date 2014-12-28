class TinymceAssetsController < ApplicationController
  def create
	geometry = Paperclip::Geometry.from_file params[:file]	

  
    image=Image.new(:picture=>image_params[:file])    
    if image.save
    else
      image.errors.full_messages
    end
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