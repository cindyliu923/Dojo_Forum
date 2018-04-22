class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.integer :replies_count, default: 0
      t.integer :viewed_count, default: 0
      t.string :status, null: false
      t.string :permit, null: false
      t.timestamps
    end

    add_index :posts, :user_id
  end
end
