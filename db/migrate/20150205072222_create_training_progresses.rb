class CreateTrainingProgresses < ActiveRecord::Migration
  def change
    create_table :training_progresses do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.date :date_of_start
      t.boolean :status

      t.timestamps
    end
  end
end
