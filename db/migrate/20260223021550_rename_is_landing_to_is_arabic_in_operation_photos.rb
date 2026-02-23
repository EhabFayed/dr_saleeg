class RenameIsLandingToIsArabicInOperationPhotos < ActiveRecord::Migration[8.0]
  def change
    rename_column :operation_photos, :is_landing, :is_arabic
  end
end
