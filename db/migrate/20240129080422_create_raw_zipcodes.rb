class CreateRawZipcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_zipcodes do |t|
      t.string :code
      t.string :prefecture
      t.string :prefecture_kana
      t.string :city
      t.string :city_kana
      t.string :town
      t.string :town_kana

      t.timestamps
    end
  end
end
