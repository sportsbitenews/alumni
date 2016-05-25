json.positions do
  json.array! @positions do |position|
    json.partial! 'position', position: position
  end
end
