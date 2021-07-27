class User < ApplicationRecord
    has_many :notes
    has_many :tags
    has_many :books
    has_secure_password
end
