class TaskProgress < ActiveRecord::Base
  belongs_to :subject_progress
  belongs_to :task
  has_many :activities
end