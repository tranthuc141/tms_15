class SubjectProgress < ActiveRecord::Base
  belongs_to :training_progress
  belongs_to :course_subject_relationship
end
