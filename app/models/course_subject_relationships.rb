class CourseSubjectRelationships < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject
  accepts_nested_attributes_for :subject, allow_destroy: true
end