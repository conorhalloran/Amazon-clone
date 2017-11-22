class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :taggings, :review_count, :reviews, :price, :sale_price, :favourites, :user

  belongs_to :category
  belongs_to :user
  has_many :reviews
  has_many :tags

  # def id
  #   object.user.full_name
  # end

  def tags
    object.tags.each do |tag|
      tag.name
    end
  end

  def created_at
      object.created_at.strftime('%Y-%B-%d')
  end

  def review_count
    object.reviews.count
  end

  def favourites
    object.favourites.count
  end

end
