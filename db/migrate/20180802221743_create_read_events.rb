class CreateReadEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :read_events do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
