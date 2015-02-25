class Course < ActiveRecord::Base
  has_many :subjects, through: :course_subject_relationships
  has_many :course_subject_relationships
  accepts_nested_attributes_for :course_subject_relationships,
    allow_destroy: true
end
