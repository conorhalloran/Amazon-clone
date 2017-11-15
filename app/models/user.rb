class User < ApplicationRecord
    has_secure_password

    has_many :products
    has_many :reviews, dependent: :nullify
    has_many :likes, dependent: :destroy
    has_many :liked_reviews, through: :likes, source: :review

    has_many :favourites, dependent: :destroy
    has_many :favourite_products, through: :favourites, source: :product

    before_validation :titleize_name
    

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :first_name, :last_name, presence: true

    before_create :generate_api_key

    def full_name
        "#{first_name} #{last_name}"
    end

    def show
        product = Product.find params[:id]
        product.user = @api_user
        render json: product
    end
    
    private

    def titleize_name
        self.first_name = first_name.titleize if first_name.present?
        self.last_name = last_name.titleize if last_name.present?
    end

    def generate_api_key
        loop do
            self.api_key = SecureRandom.urlsafe_base64(64)
            break unless User.exists?(api_key: self.api_key)
        end
    end

    def authenticate_api_user
        @api_user = User.find_by_api_key request.headers['HTTP_API_KEY']
        head :unauthorized unless @api_user
    end
    
end
