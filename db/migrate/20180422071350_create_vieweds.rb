class CreateVieweds < ActiveRecord::Migration[5.1]
  def change
    create_table :vieweds do |t|
      t.integer :post_id
      t.integer :user_id
      t.timestamps
    end

    add_index :vieweds, [:post_id, :user_id]
  end
end
