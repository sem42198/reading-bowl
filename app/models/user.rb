class User < ApplicationRecord
  has_many :questions
  has_many :answer_events, dependent: :destroy
  has_many :read_events, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :books, through: :read_events

  enum user_type: %i[student instructor]

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :user_type, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true

  serialize :question_queue, Hash

  def name
    "#{first_name} #{last_name}"
  end

  def points
    nil if instructor?
    answer_events.size + read_events.size * 10 + attendances.size
  end

  def unread_books
    Book.all - books
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

  def build_question_queue(book, starred_only)
    queue = if starred_only
              book.questions.where(starred: true).collect(&:id).shuffle
            else
              book.questions.collect(&:id).shuffle
            end
    question_queue[book.id] = queue
    save
    !queue.empty?
  end

  def pop_question(book_id)
    q = question_queue[book_id].pop
    save
    q
  end

  def clear_question_queue
    self.question_queue = {}
    save
  end

end
