class CreateMiscs < ActiveRecord::Migration[7.1]
  def change
    create_table :miscs do |t|
      t.string :date
      t.string :state
      t.string :seat
      t.string :race_type

      t.timestamps
    end
  end
end
