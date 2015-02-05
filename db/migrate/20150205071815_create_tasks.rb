class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.text :content
      t.references :subject

      t.timestamps
    end
  end
end
