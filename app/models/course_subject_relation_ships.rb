class CourseSubjectRelationShips < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject
end
