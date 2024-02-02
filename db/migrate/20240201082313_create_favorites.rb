class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :event, null: false, foreign_key: { to_table: :events }

      t.timestamps
    end
    add_index :favorites, [:user_id, :event_id], unique: true
  end
end
