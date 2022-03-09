class Question < ApplicationRecord
  validates :description, presence: true
  belongs_to :quiz
end
