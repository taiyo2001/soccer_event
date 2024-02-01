class CreateEventComments < ActiveRecord::Migration[7.0]
  def change
    create_table :event_comments, comment: 'イベント参加者コメント' do |t|
      t.references :event, foreign_key: true, comment: 'コメントが展開さされてるイベント'
      t.references :user, foreign_key: true, comment: 'コメントしたユーザ'
      t.text :content, null: false

      t.timestamps
    end
  end
end
