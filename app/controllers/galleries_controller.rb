class GalleriesController < ApplicationController

  def index
    galleries = Gallery.order(:id).map do |gallery|
      {
        id: gallery.id,
        title_ar: gallery.title_ar,
        title_en: gallery.title_en,
        is_published: gallery.is_published,
        gallery_photos: gallery.gallery_photo.order(:id).map do |photo|
          {
            id: photo.id,
            alt_ar: photo.alt_ar,
            alt_en: photo.alt_en,
            url: photo.photo.attached? ? photo.cached_photo_url : nil
          }
        end
      }
    end
    render json: galleries
  end
  def show
    gallery = Gallery.find(params[:id])
    render json: {
      id: gallery.id,
      title_ar: gallery.title_ar,
      title_en: gallery.title_en,
      is_published: gallery.is_published,
      gallery_photos: gallery.gallery_photo.order(:id).map do |photo|
        {
          id: photo.id,
          alt_ar: photo.alt_ar,
          alt_en: photo.alt_en,
          url: photo.photo.attached? ? photo.cached_photo_url : nil
        }
      end
    }
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
  params.require(:gallery).permit(:title_ar, :title_en, :is_published, gallery_photo_attributes: [:id, :photo, :alt_ar, :alt_en, :_destroy])
end
end
