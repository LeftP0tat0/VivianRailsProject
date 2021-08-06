class Book < ApplicationRecord
  belongs_to :user
  has_many :notes

  scope :with_long_name, ->(length = 6) {where("LENGTH(title) > ?", length) }
  scope :with_short_name, ->(length = 7) {where("LENGTH(title) < ?", length) }

end
