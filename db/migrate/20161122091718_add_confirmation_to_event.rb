class AddConfirmationToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :confirmation, :boolean, default: false
  end
end
