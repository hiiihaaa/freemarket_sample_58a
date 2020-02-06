json.array! Category.find(params[:parent]).children do |child|
  json.id   child.id
  json.name child.name
end