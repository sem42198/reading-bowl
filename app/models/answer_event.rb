class AnswerEvent < ApplicationRecord

  has_one :question
  belongs_to :user

  validates :user_id, :presence => true

  def book
    question.book
  end
end
