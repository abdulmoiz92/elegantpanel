class ChangeTypeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :type, :producttype
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
