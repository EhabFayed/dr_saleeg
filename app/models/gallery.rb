class Gallery < ApplicationRecord
  validates :title_ar, :title_en, presence: true

  has_many :gallery_photo, dependent: :destroy
  accepts_nested_attributes_for :gallery_photo, allow_destroy: true
  scope :published, -> { where(is_published: true) }

end