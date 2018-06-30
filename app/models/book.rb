class Book < ApplicationRecord

  has_many :questions

  accepts_nested_attributes_for :questions

  validates_uniqueness_of :title, :scope => [:author]

  validates :title, :presence => true
  validates :author, :presence => true
end
