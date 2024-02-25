class CreateSenates < ActiveRecord::Migration[7.1]
  def change
    create_table :senates do |t|
      t.string :date
      t.string :state
      t.string :senate_class

      t.timestamps
    end
  end
end
