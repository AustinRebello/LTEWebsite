class CreateHouses < ActiveRecord::Migration[7.1]
  def change
    create_table :houses do |t|
      t.string :date
      t.string :state
      t.string :seat

      t.timestamps
    end
  end
end
