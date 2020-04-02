class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string :email, null: false, unique: true
    	t.string :first_name
    	t.string :last_name
    	t.string :password_digest
    	t.string :image_url
    	t.datetime :last_login
      t.timestamps
    end
  end
end


