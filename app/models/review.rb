class Review < ApplicationRecord
    belongs_to :product
    belongs_to :user, optional: true

    validates(:rating,{
        numericality:{less_than_or_equal_to:5, only_integer: true}    
    })
    validates(:body, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
end
