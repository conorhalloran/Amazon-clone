class Review < ApplicationRecord
    belongs_to :product
    belongs_to :user, optional: true
    has_many :likes, dependent: :destroy
    has_many :users, through: :likes


    validates(:rating,{
        numericality:{less_than_or_equal_to:5, only_integer: true}    
    })
    validates(:body, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
end
