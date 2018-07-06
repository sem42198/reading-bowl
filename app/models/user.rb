class User < ApplicationRecord

  has_many :questions

  enum user_type: [ :student, :instructor ]

  has_secure_password

  validates :email, :presence => true, :uniqueness => true
  validates :username, :presence => true, :uniqueness => true
  validates :user_type, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password_digest, :presence => true

  def name
    "#{first_name} #{last_name}"
  end
end
