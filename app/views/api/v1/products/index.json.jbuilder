json.products @products do |product|
    json.id product.id
    json.title product.title
    json.created_at product.created_at.strftime('%d-%B-%Y')
    json.user do
        json.first_name product.user.first_name
        json.last_name product.user.last_name
    end
    json.tags do
        json.name product.tags.name
    end
    json.review_count product.reviews.count
    json.reviews product.reviews

end