class Subject < ActiveRecord::Base
  has_many :course_subject_relationships, dependent: :destroy
  has_many :courses, through: :course_subject_relationships
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks
end
