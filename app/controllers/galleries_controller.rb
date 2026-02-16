class GalleriesController < ApplicationController

  def index
    galleries = Gallery.all
    render json: galleries
  end
  def show
    gallery = Gallery.find(params[:id])
    render json: gallery
  end
  def create
    gallery = Gallery.new(gallery_params)
    if gallery.save
      render json: {message: "Gallery created successfully"}
    else
      render json: { errors: gallery.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def update
    gallery = Gallery.find(params[:id])
    if gallery.update(gallery_params)
      render json: {message: "Gallery updated successfully"}
    else
      render json: { errors: gallery.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
    render json: {message: "Gallery deleted successfully"}, status: :ok
  end
private

def gallery_params
  params.require(:gallery).permit(:title_ar, :title_en, :is_published, gallery_photos_attributes: [:id, :photo, :alt_ar, :alt_en, :is_arabic, :_destroy])
end
end