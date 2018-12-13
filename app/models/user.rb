class User < ApplicationRecord
  has_many :questions
  has_many :answer_events
  has_many :read_events
  has_many :attendances

  enum user_type: %i[student instructor]

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :user_type, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def points
    nil if instructor?
    answer_events.size + read_events.size * 10 + attendances.size
  end

  def books
    return nil if instructor?

    read = []
    read_events.each do |ev|
      read.push(ev.book_id)
    end
    read.collect { |id| Book.find(id) }
  end

  def unread_books
    return nil if instructor?

    read = books.collect(&:id)
    unread = []
    Book.all.each do |book|
      unread.push book unless read.include? book.id
    end
    unread
  end

  def questions_answered(book)
    book.answer_events.select { |ev| ev.user_id == id }.size
  end

  def top_books(num = 0)
    num -= 1
    Book.all.sort_by { |book| -questions_answered(book) }[0..num]
  end

  def self.students
    User.where(user_type: :student)
  end

  def self.instructors
    User.where(user_type: :instructor)
  end
end
