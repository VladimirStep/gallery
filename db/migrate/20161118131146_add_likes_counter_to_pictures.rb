class AddLikesCounterToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :likes_count, :integer
  end
end
