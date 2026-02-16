class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.string :title_ar
      t.string :title_en
      t.string :video_url
      t.string :img_alt_text_ar
      t.string :img_alt_text_en
      t.string :cover_image
      t.boolean :is_published, default: false
      t.timestamps
    end
  end
end
