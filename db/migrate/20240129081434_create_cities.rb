class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :kana
      t.references :prefecture, foreign_key: true

      t.timestamps
    end
  end
end
