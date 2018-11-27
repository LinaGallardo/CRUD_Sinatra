class CreateProducts < ActiveRecord::Migration[5.2]
  def self.up
    create_table :products do |t|
      t.string :name, null: false
      t.integer :value, null: false
      t.string :brand, null: false
      t.string :description
      t.integer :quantity
    end
  end

  def self.down
    drop_table :products
  end
end
