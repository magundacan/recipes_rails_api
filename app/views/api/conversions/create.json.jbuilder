if @converted
  json.original do
    json.rational_value @original.value
    json.float_value @original.value.to_f
    json.unit @original.unit
  end
  json.converted do
    json.rational_value @converted.value
    json.float_value @converted.value.to_f
    json.unit @converted.unit
  end
else
  json.error "conversion not supported"
end
