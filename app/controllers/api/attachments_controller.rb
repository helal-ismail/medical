class Api::AttachmentsController < ApiController

  def upload
    result = Cloudinary::Uploader.upload(params[:image])
    render :json => {:data => result }
  end



end
