class VideosController < ApplicationController
  def index
    videos = Video.order(:id).map do |video|
      {
        id: video.id,
        title_ar: video.title_ar,
        title_en: video.title_en,
        video_url: video.video_url,
        is_published: video.is_published,
        img_alt_text_ar: video.img_alt_text_ar,
        img_alt_text_en: video.img_alt_text_en,
        cover_image: video.cover_image.attached? ? video.cached_cover_image_url : nil
      }
    end
    render json: videos
  end
  def show
    video = Video.find(params[:id])
    render json: {
      id: video.id,
      title_ar: video.title_ar,
      title_en: video.title_en,
      video_url: video.video_url,
      is_published: video.is_published,
      img_alt_text_ar: video.img_alt_text_ar,
      img_alt_text_en: video.img_alt_text_en,
      cover_image: video.cover_image.attached? ? video.cached_cover_image_url : nil
    }
  end
  def create
    video = Video.new(video_params)
    if video.save
      render json: {message: "Video created successfully"}
    else
      render json: { errors: video.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def update
    video = Video.find(params[:id])
    if video.update(video_params)
      render json: {message: "Video updated successfully"}
    else
      render json: { errors: video.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def destroy
    video = Video.find(params[:id])
    video.destroy
    render json: {message: "Video deleted successfully"}, status: :ok
  end



  private

  def video_params
    params.require(:video).permit(:title_ar, :title_en, :video_url, :is_published,:img_alt_text_ar,:img_alt_text_en,:cover_image)
  end
end