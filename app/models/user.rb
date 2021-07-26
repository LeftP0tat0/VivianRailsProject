class User < ApplicationRecord
    has_many :Notes
    has_many :tags
    has_many :books
    has_secure_password
end
