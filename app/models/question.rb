class Question < ApplicationRecord
  validates :description, presence: true
  validate :answers_count
  belongs_to :quiz

  has_many :answers

  accepts_nested_attributes_for :answers,
                                allow_destroy: true,
                                reject_if: proc { |attr| attr['title'].blank? }

  private

  def answers_count
    return if answers.count == 5 && answers.where('is_correct = ?', true).count == 1

    errors.add(:base, 'each question must have five answers with only of them correct')
  end
end
