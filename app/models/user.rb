class User < ApplicationRecord
    require 'securerandom'
    
    has_many :books, through: :notes
    has_many :books
    has_many :notes, through: :books
    has_secure_password

    def self.find_or_create_from_auth(auth)
        @user = User.find_or_create_by(uid: auth['uid'])
    
        @user.username = auth['info']['nickname']
        @user.email = auth['info']['email']
        @user.password = SecureRandom.hex(10)

        @user.save
        @user
    end

    private

    def provider_data
        params.require(:user).permit(:username, :email, :password)
    end

end
