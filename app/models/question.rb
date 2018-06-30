class Question < ApplicationRecord
  has_one :user
  belongs_to :book

  validates :book_id, :presence => true
  validates :question, :presence => true
  validates :answer, :presence => true

  validates_uniqueness_of :question, :scope => [:book_id]

  after_initialize :default_values

  private
  def default_values
    self.starred ||= false
  end
end
