class RemovePictureNameFromPictures < ActiveRecord::Migration[5.0]
  def change
    remove_column :pictures, :picture_name, :string
  end
end
