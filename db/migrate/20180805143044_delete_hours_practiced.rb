class DeleteHoursPracticed < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :hours_practiced
  end
end
