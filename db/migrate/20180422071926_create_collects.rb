class CreateCollects < ActiveRecord::Migration[5.1]
  def change
    create_table :collects do |t|
      t.integer :post_id
      t.integer :user_id
      t.timestamps
    end

    add_index :collects, [:post_id, :user_id]
  end
end
