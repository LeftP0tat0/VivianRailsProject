class Book < ApplicationRecord
  belongs_to :user
  has_many :notes
  has_many :tags

  scope :with_long_name, ->(length = 6) {where("LENGTH(name) > ?", length) }
  scope :with_short_name, ->(length = 7) {where("LENGTH(name) < ?", length) }

end
