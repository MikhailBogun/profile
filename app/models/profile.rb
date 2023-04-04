class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :birthdate, presence: true, inclusion: { in: 100.years.ago..Date.today, message: "must be between 100 years ago and today" }
  validates :city, presence: true
  validates :gender, inclusion: { in: %w(male female), message: "must be either male or female" }
end
