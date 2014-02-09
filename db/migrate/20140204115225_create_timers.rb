class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.integer :minutes
      t.datetime :started_at
      t.references :list_item, index: true

      t.timestamps
    end
  end
end
