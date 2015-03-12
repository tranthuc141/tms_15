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
    elsif TrainingProgress.find_by(course_id: course.id).status.nil?
      'Not started yet'
    else
      'Done'
    end
  end

  def quantity_subject_done(training_progress)
    subjects = training_progress.subject_progresses
    subjects.select{|s| s.status == false}.count
  end

  def quantity_task_done(training_progress)
    subjects = training_progress.subject_progresses
    subjects.map{|sub| sub.task_progresses.select{|t| t.status == false}.count}.inject(:+)
  end

  def get_training_progress(course, user)
    training_progress = TrainingProgress.find_by user_id: user.id,
      course_id: course.id
  end
end
