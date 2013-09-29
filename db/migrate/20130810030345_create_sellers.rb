class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :name, :null => false, :unique => true

      t.timestamps
    end
  end
end
