class CreateGalleryPhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :gallery_photos do |t|
      t.references :gallery, null: false, foreign_key: true
      t.string :alt_ar
      t.string :alt_en
      t.timestamps
    end
  end
end
