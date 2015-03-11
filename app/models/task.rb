class Task < ActiveRecord::Base
  belongs_to :subject
  has_many :subject_progresses, through: :task_progresses
  has_many :task_progresses, dependent: :destroy

  def get_task_progress(task, user, course)
    subject = task.subject
    training_progress = TrainingProgress.find_by course_id: course.id,
      user_id: user.id
    subject_progress = SubjectProgress.find_by subject_id: subject.id,
      training_progress_id: training_progress.id
    task_progress = TaskProgress.find_by task_id: task.id,
      subject_progress_id: subject_progress.id
    return task_progress
  end
end
