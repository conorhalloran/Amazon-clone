class Product < ApplicationRecord
    belongs_to :category
    belongs_to :user, optional: true
    has_many :reviews, dependent: :destroy
    
    after_initialize :set_defaults
    before_save :titleize_title

    validates(:title, {
        presence: {message: 'must be provided'},
        uniqueness: true
    })
    validates(:description, {
        presence: {message: 'must be provided'},
        length: {minimum: 10, maximum: 2000}
    })
    validates(:price, numericality: {
        greater_than_or_equal_to: 0
    })

    scope :search, -> (string) { where('title ILIKE ?', "%#{string}%").or(where('description ILIKE ?', "%#{string}%")).order('title, description') }

    # def self.search(string)
    #     where('title ILIKE ?', "%#{string}%").or(self.where('description ILIKE ?', "%#{string}%")).order('title, description')    
    # end

    after_initialize :set_defaults
    before_validation :titleize_title

    private
    def titleize_title
        self.title = title.titleize if title.present?
    end

    def set_defaults
        # You can read any attribute inside a model's class by just refering to it by name, but you must prefix it with '.self' if you want to write to it.
        self.price ||= 1 #or equal
    end
end
