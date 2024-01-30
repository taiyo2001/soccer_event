class CreatePrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :prefectures do |t|
      t.string :name, unique: true
      t.string :kana, unique: true

      t.timestamps
    end
  end
end
