class CreateZipcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :zipcodes, id: :string  do |t|

      t.timestamps
    end
  end
end
