class Question < ApplicationRecord
  validates :description, presence: true
  validate :answers_count
  belongs_to :quiz

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers,
                                allow_destroy: true,
                                reject_if: proc { |attr| attr['value'].blank? }

  private

  def answers_count
    return if answers.length >= 5 && answers.filter { |answer| answer.is_correct == true }

    errors.add(:base, 'each question must have five answers with only of them correct')
  end
end
