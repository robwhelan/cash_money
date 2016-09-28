class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :category
      t.string :subcategory

      t.timestamps null: false
    end
  end
end
