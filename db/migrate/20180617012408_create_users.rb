class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|

      t.string :username
      t.integer :user_type
      t.string :email
      t.string :first_name
      t.string :last_name
      t.float :hours_practiced
      t.string :password_digest

      t.timestamps
    end
  end
end
