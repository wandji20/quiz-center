class Quiz < ApplicationRecord
  before_save :downcase_title

  TITLES = ['general', 'technology', 'culture', 'social']

  validates :title, presence: true, uniqueness: true

  has_many :questions

  private
  def downcase_title
    self.title = title.downcase if title.present?
  end
end
