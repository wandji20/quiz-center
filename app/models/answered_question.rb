class AnsweredQuestion < ApplicationRecord
  validate :validate_answered_at, on: :update

  belongs_to :user
  belongs_to :question
  belongs_to :answer, optional: true

  private

  def validate_answered_at
    time_exceeded = DateTime.now.to_i > question.points.minutes.to_i + created_at.to_i
    errors.add(:base, 'time limit exceeded') if time_exceeded
  end
end
