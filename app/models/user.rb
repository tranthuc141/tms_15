class User < ActiveRecord::Base
  has_many :training_progresses
  has_many :courses, through: :training_progresses
  has_many :reports, dependent: :destroy
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 50}
  validates :password, length: {minimum: 6}, allow_blank: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password

  has_many :courses, through: :training_progresses
  has_many :training_progresses, dependent: :destroy
  has_many :activities

  def update_progress_info(training_progresses)
    training_progresses.each do |training_progress|
      training_progress.update_attributes subject_ids: training_progress.course.subjects.ids
      training_progress.subject_progresses.each do |sub_pro|
        sub_pro.update_attributes task_ids: sub_pro.subject.tasks.ids
      end
    end
    activities.create! name: "Updated subjects in course"
  end

  def start_course(course)
    training_progresses = course.training_progresses
    training_progresses.each do |training_progress|
      training_progress.update_attributes status: true
    end
    activities.create! name: "Started course #{course.name}"
  end

  def finish_course(course)
    training_progresses = course.training_progresses
    training_progresses.each do |training_progress|
      training_progress.update_attributes status: false
    end
    activities.create! name: "Finished course #{course.name}"
  end

  def trainee_start_subject(subject_progress)
    subject_progress.update_attributes status: true
    subject_progress.task_progresses.each do |tas_pro|
      tas_pro.update_attributes status: true
    end
    activities.create! name: "Started subject #{subject_progress.subject.name}",
      subject_progress_id: subject_progress.id
  end

  def trainee_finish_subject(subject_progress)
    subject_progress.update_attributes status: false
    activities.create! name: "Finished subject #{subject_progress.subject.name}"
  end

  def supervisor_finish_subject(subject_progresses)
    subject_progresses.each do |sub_pro|
      sub_pro.update_attributes status: false
    end
    subject_name = subject_progresses.first.subject.name
    activities.create! name: "Finished subject #{subject_name}"
  end

  def done_task(task_progress)
    task_progress.update_attributes status: false
    activities.create! name: "Done task #{task_progress.task.name}"
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes!(remember_digest:User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes!(remember_digest:nil)
  end

  private
  def downcase_email
    self.email = email.downcase
  end

end
