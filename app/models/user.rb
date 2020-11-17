class User < ApplicationRecord
	has_secure_password

	PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  /x

	validates :password,
    presence: true,
    length: { within: 8..40 },
    format: { with: PASSWORD_FORMAT },
    confirmation: true,
    on: :create

  validates :password,
    allow_nil: true,
    length: { within: 8..40 },
    format: { with: PASSWORD_FORMAT },
    confirmation: true,
		on: :update
		
	validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
