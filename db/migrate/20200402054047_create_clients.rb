class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.text :client_id
      t.text :client_secret
      t.string :grant_type

      t.timestamps
    end
  end
end
