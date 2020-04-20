class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :authentication_token, :id
end
