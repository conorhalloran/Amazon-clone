class ReviewSerializer < ActiveModel::Serializer
  
  belongs_to :products
  
  
  attributes :id, :body

  def id
    object.user.full_name
  end

end
