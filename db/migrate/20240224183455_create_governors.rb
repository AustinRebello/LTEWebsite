class CreateGovernors < ActiveRecord::Migration[7.1]
  def change
    create_table :governors do |t|
      t.string :date
      t.string :state

      t.timestamps
    end
  end
end
