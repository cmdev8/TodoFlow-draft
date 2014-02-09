class AddStartedAtToLists < ActiveRecord::Migration
  def change
    add_column :lists, :started_at, :datetime
  end
end
