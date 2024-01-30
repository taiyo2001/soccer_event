class CreateTowns < ActiveRecord::Migration[7.0]
  def change
    create_table :towns do |t|
      t.string :name
      t.string :kana
      t.references :city, foreign_key: true
      t.references :zipcode, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
