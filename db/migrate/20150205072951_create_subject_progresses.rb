class CreateSubjectProgresses < ActiveRecord::Migration
  def change
    create_table :subject_progresses do |t|
      t.references :training_progress, index: true
      t.references :subject, index: true
      t.boolean :status

      t.timestamps
    end
  end
end
