json.ratings @ratings do |rating|
  json.id rating.id
  json.score rating.score
  json.comment rating.comment
  json.created_at rating.created_at
  json.updated_at rating.updated_at
  json.user rating.user
end
