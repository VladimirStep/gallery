class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :picture_name
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
