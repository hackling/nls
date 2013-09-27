class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :sales do |t|

      t.timestamps
    end

    create_table :transactions do |t|
      t.references :seller, :null => false
      t.string :transaction_type, :null => false
      t.decimal :amount, :null => false
      t.references :sale, :null => false

      t.timestamps
    end
    add_index :transactions, :seller_id
    add_index :transactions, :transaction_type
  end
end
