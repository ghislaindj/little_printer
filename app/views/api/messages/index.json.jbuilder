json.array! @messages do |message|
  json.title message.title
  json.text message.text
  json.username message.username
end