class CreateUserWidgets < ActiveRecord::Migration[5.2]
  def change
    create_table :user_widgets do |t|
      t.references :user, foreign_key: true
      t.references :widget, foreign_key: true

      t.timestamps
    end
  end
end
