class Client < ApplicationRecord
    has_secure_password
    belongs_to :store

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
    validates :password, length: { in: 6..20 }, presence: true
end
