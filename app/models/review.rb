class Review < ApplicationRecord
    belongs_to :product
    belongs_to :user, optional: true

    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user


    validates(:rating,{
        numericality:{less_than_or_equal_to:5, only_integer: true}    
    })
    validates(:body, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })

    def like_for(user)
        likes.find_by_user_id(user)
    end
end
