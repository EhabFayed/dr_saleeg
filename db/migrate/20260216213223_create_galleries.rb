class CreateGalleries < ActiveRecord::Migration[8.0]
  def change
    create_table :galleries do |t|
      t.string :title_ar
      t.string :title_en
      t.boolean :is_published, default: false
      t.timestamps
    end
  end
end
