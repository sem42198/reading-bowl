class AnswerEvent < ApplicationRecord

  belongs_to :question
  belongs_to :answerer, foreign_key: :user_id, class_name: 'User'
  has_one :book, through: :question

  validates :user_id, presence: true

end
