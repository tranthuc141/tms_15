class Task < ActiveRecord::Base
  belongs_to :subject
  has_many :subject_progresses, through: :task_progresses
  has_many :task_progresses, dependent: :destroy
end
