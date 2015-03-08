class TaskProgress < ActiveRecord::Base
  belongs_to :subject_progress
  belongs_to :task
end