json.array!(@posts) do |post|
  json.extract! post, :id, :references, :references, :string, :text, :integer, :integer
  json.url post_url(post, format: :json)
end
