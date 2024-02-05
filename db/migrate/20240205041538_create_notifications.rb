class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.string :message,  null: false
      t.string :url,      null: false

      t.timestamps
    end
  end
end
