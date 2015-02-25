class Subject < ActiveRecord::Base
  has_many :course_subject_relationships, dependent: :destroy
  has_many :courses, through: :course_subject_relationships
end
