class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :task_progress_id
      t.integer :subject_progress_id
      t.integer :training_progress_id
      t.string :name

      t.timestamps
    end
  end
end
