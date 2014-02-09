class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.references :list, index: true
      t.text :content
      t.datetime :deadline_at
      t.datetime :done_at

      t.timestamps
    end
  end
end
