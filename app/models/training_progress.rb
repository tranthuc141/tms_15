class TrainingProgress < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :subject_progresses, dependent: :destroy
  has_many :subjects, through: :subject_progresses
end
