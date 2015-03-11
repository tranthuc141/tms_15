class SubjectProgress < ActiveRecord::Base
  belongs_to :training_progress, dependent: :destroy
  belongs_to :subject
  has_many :task_progresses
  has_many :tasks, through: :task_progresses
  has_many :activities
end
