class Course < ActiveRecord::Base
  has_many :subjects, through: :course_subject_relationships
  has_many :course_subject_relationships, dependent: :destroy
  has_many :users, through: :training_progresses
  has_many :training_progresses, dependent: :destroy

  accepts_nested_attributes_for :course_subject_relationships,
    allow_destroy: true
  accepts_nested_attributes_for :training_progresses, allow_destroy: true

  def get_status(course)
    if TrainingProgress.find_by(course_id: course.id).status
      'Learning'
    else
      'Done'
    end
  end
end
