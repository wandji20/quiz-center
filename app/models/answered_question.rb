class AnsweredQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer, optional: true
end
