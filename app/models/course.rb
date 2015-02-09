class Course < ActiveRecord::Base
  has_many :subjects, dependent: :destroy
end
