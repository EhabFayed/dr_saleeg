class Video < ApplicationRecord
  validates :title_ar, :title_en,:video_url, presence: true
  has_one_attached :cover_image
  after_commit :clear_cover_image_cache, on: %i[update destroy]
  scope :published, -> { where(is_published: true) }
  def cached_cover_image_url
    return nil unless cover_image.attached?

    Rails.cache.fetch("video_cover_image_url_#{id}", expires_in: 12.hours) do
      Rails.application.routes.url_helpers.url_for(cover_image)
    end
  end

  private

  def clear_cover_image_cache
    Rails.cache.delete("video_cover_image_url_#{id}")
  end
end