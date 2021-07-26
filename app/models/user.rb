class User < ApplicationRecord
    has_many :Notes
    has_many :tags
    has_many :books
end
