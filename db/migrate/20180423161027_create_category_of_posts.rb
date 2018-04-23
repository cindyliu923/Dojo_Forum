class CreateCategoryOfPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :category_of_posts do |t|
      t.integer :post_id
      t.integer :category_id
      t.timestamps
    end

    add_index :category_of_posts, [:post_id, :category_id]
  end
end
