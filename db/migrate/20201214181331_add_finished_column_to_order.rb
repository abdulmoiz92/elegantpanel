class AddFinishedColumnToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :finished, :boolean, :default => false
    #Ex:- :default =>''
  end
end
