class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, 
                      length: { in: 2..50 },
                      format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX },
            length: { maximum: 255 }

  validates :password, :password_confirmation, presence: true, length: { in: 6..72 }

  has_secure_password

  has_many :answered_questions

  def unanswered_questions
    answered_question_ids = answered_questions.pluck(:question_id)
    Question.where.not(id: answered_question_ids)
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
