class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :url, :id
end
