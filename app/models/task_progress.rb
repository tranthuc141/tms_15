class TaskProgress < ActiveRecord::Base
  belongs_to :subject_progres
  belongs_to :task
end
