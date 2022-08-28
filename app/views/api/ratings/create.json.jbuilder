if @error_messages.nil?
  json.rating @rating
else
  json.errors @error_messages
end
