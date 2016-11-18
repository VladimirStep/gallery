class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.boolean :status, default: false
      t.references :picture, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
