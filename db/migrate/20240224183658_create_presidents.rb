class CreatePresidents < ActiveRecord::Migration[7.1]
  def change
    create_table :presidents do |t|
      t.string :date
      t.string :state

      t.timestamps
    end
  end
end
