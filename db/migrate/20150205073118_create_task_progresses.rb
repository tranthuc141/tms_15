class CreateTaskProgresses < ActiveRecord::Migration
  def change
    create_table :task_progresses do |t|
      t.references :subject_progress, index: true
      t.references :task, index: true
      t.date :date_of_start
      t.boolean :status

      t.timestamps
    end
  end
end
