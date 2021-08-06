class User < ApplicationRecord
    has_many :tags, through: :notes
    has_many :books
    has_many :notes, through: :books
    has_secure_password

    #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

    def self.create_from_provider_data(provider_data)
        where(provided: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
            user.email = provider_data.info.email
            user.password = devise.friendly_token[0, 20]
        end
    end

    private

    def provider_data
        params.require(:user).permit(:username, :email, :password)
    end

end
