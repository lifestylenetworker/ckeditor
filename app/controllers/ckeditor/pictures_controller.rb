class Ckeditor::PicturesController < Ckeditor::ApplicationController

  def index
    @pictures = Ckeditor.picture_model.find_all(:conditions => { assetable_id: current_user.id, assetable_type: "User" })
    respond_with(@pictures) 
  end
  
  def create
    @picture = Ckeditor::Picture.new
	  respond_with_asset(@picture)
  end
  
  def destroy
    @picture.destroy
    respond_with(@picture, :location => pictures_path)
  end
  
  protected
  
    def find_asset
      @picture = Ckeditor.picture_model.get!(params[:id])
    end

    def authorize_resource
      model = (@picture || Ckeditor::Picture)
      @authorization_adapter.try(:authorize, params[:action], model)
    end
end
