class AddTimerStartedAtToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :timer_started_at, :datetime
  end
end
