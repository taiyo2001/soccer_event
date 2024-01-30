class CreateTeamComments < ActiveRecord::Migration[7.0]
  def change
    create_table :team_comments do |t|
      t.references :user, null: false,  foreign_key: { to_table: :users }
      t.references :team, null: false,  foreign_key: { to_table: :teams }
      t.text :content,    null: false

      t.timestamps
    end
  end
end
