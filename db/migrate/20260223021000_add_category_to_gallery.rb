class AddCategoryToGallery < ActiveRecord::Migration[8.0]
  def change
    add_column :galleries, :category, :integer, default: 0
  end
end
