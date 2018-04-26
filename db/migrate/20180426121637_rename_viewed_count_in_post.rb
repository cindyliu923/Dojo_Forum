class RenameViewedCountInPost < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :viewed_count, :vieweds_count
  end
end
