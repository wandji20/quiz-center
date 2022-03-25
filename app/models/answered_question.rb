class AnsweredQuestion < ApplicationRecord
  validate :answered_at, on: :update

  belongs_to :user
  belongs_to :question
  belongs_to :quiz
  belongs_to :answer, optional: true

  scope :correct, -> { joins(:answer).where(answer: { is_correct: true }) }

  def updatable?
    DateTime.now.to_i <= question.points.minutes.to_i + created_at.to_i
  end

  private

  # enforce validation when updating an answered question or when updation for after the first time
  def answered_at
    errors.add(:base, 'time limit exceeded') unless updatable?
    return if created_at == updated_at

    errors.add(
      :base, 'Can\'t submit answer twice for thesesame question'
    )
  end
end
