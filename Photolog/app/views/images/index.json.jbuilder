json.array!(@images) do |image|
  json.extract! image, :id, :title, :descrption, :point, :idUser
  json.url image_url(image, format: :json)
end
