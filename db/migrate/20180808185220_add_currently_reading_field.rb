class AddCurrentlyReadingField < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :currently_reading, :text
  end
end
