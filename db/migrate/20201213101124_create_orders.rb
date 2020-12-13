class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :type
      t.string :quantity
      t.string :buysell
      t.float :platform
      t.float :client
      t.string :time

      t.timestamps
    end
  end
end
