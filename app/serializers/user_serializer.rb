class UserSerializer < ActiveModel::Serializer
  attributes :username, :gravatar_url, :email


  def gravatar_url
    email = object&.email&.downcase || ''
    gravatar_id = Digest::MD5.hexdigest(email)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=40"
  end
end
