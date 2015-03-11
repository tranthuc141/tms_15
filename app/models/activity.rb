class Activity < ActiveRecord::Base
  belongs_to :task_progress
  belongs_to :subject_progress
  belongs_to :training_progress
  belongs_to :user
end
