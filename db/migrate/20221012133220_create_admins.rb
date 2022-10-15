class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|

      t.timestamps
      t.string :email, null: false
      t.string :encrypted_password, null: false
      
    end
  end
end
