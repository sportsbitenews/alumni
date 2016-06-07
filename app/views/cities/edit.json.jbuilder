json.partial! 'teachers'
json.partial! 'teaching_assistants'
json.city do
  json.name @city.name
  json.slug @city.slug
end
