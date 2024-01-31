class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, comment: 'イベント' do |t|
      t.references :master, foreign_key: { to_table: :users }, comment: 'イベント主催者'
      t.references :zipcode, foreign_key: true, type: :string, comment: 'イベント場所の郵便番号'
      t.string :name, null: false, comment: 'イベント名'
      t.string :address, null: false, comment: '住所'
      t.string :place, null: false, comment: '場所'
      t.text :description, null: false, comment: '詳細'
      t.integer :price, comment: '参加費用'
      t.integer :people_limit, comment: '人数制限'
      t.datetime :held_at, null: false, comment: '開催日時'
      t.datetime :deadline_at, null: false, comment: '申込締切日時'

      t.timestamps
    end
  end
end
