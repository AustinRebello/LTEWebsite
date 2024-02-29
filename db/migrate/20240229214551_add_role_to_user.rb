class AddRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, default:false
    add_column :users, :super_user, :boolean, default:false
  end
end
