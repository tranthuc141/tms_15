class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
    add_index :reports, [:user_id, :created_at]
  end
end
