class Category < ApplicationRecord
    has_many :products

    validates(:name, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
end
