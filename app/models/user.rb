class User < ApplicationRecord
  before_save :downcase_email
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :last_name, :email,  presence: true
  validates :first_name, :last_name, length: { in: 2..50 }
  validates :email,
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX },
            length: { maximum: 255 }
  validates :password, :password_confirmation, presence: true, length: { in: 6..72 }


  has_secure_password

  private
  def downcase_email
    self.email = email.downcase if email.present?
  end
end
