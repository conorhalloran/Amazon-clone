class User < ApplicationRecord
    has_secure_password

    has_many :products
    has_many :reviews

    before_validation :titleize_name

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :first_name, :last_name, presence: true

    def full_name
        "#{first_name} #{last_name}"
    end
    
    def titleize_name
        self.first_name = first_name.titleize if first_name.present?
        self.last_name = last_name.titleize if last_name.present?
    end
    
end
