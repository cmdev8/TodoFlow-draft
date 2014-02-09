class AddStartedAtToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :started_at, :datetime
    remove_column :lists, :started_at
  end
end
