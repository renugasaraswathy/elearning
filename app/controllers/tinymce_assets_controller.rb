class TinymceAssetsController < ApplicationController
  def create
	geometry = Paperclip::Geometry.from_file params[:file]
	file=params[:file].path
    image = Image.create(:picture=>File.open(file))

    render json: {
      image: {
        url: image.picture.url
      }
    }, content_type: "text/html"
  end
end