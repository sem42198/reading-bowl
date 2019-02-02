class ReadEvent < ApplicationRecord

  belongs_to :book
  belongs_to :reader, class_name: 'User', foreign_key: :user_id

  validates :user_id, :presence => true
  validates :book_id, :presence => true

  validates_uniqueness_of :book_id, :scope => [:user_id]
end
