class CreateSubjectProgresses < ActiveRecord::Migration
  def change
    create_table :subject_progresses do |t|
      t.references :training_progress, index: true
      t.references :course_subject_relationship, index: true

      t.timestamps
    end
  end
end
