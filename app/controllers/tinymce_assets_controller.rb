class TinymceAssetsController < ApplicationController
  def create
	geometry = Paperclip::Geometry.from_file params[:file]	

    puts "\n\n\n\n\n\n after geometry"
    image=Image.new(:picture=>image_params[:file])    
    puts "after image new"
    if image.save
    else
      puts image.errors.full_messages
    end
    puts "after image save"
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