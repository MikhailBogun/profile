class User < ApplicationRecord
  has_many :sections, dependent: :destroy

  has_secure_password

  validates :username, allow_blank: false,
                       length: {
                         minimum: Constants::User::MIN_USERNAME_LENGTH,
                         maximum: Constants::User::MAX_USERNAME_LENGTH
                       }
  validates :password_digest, allow_blank: false, length: { minimum: Constants::User::MIN_PASSWORD_LENGTH },
                       format: { with: Constants::User::PASSWORD_FORMAT,
                                 message: I18n.t('validation.password.length') }

  def valid_password?(param_password)
    password_digest.match(param_password)
  end
end
