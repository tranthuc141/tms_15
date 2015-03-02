class Course < ActiveRecord::Base
  has_many :subjects, through: :course_subject_relationships
  has_many :course_subject_relationships
  has_many :users, through: :training_progresses
  has_many :training_progresses

  accepts_nested_attributes_for :course_subject_relationships,
    allow_destroy: true
  accepts_nested_attributes_for :training_progresses, allow_destroy: true
end
