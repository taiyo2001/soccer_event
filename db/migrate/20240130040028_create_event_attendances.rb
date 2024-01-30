class CreateEventAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :event_attendances do |t|
      t.references :event, foreign_key: true, comment: '参加申込イベント'
      t.references :user, foreign_key: true, comment: 'イベント申込者'
      t.string :status, null: false, comment: 'ステータス'

      t.timestamps
    end
  end
end
