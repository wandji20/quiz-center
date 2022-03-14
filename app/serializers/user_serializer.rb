class UserSerializer < ActiveModel::Serializer
  attributes :name, :gravatar_url

  def name
    object.name
  end

  def gravatar_url
    email = object&.email&.downcase || ''
    gravatar_id = Digest::MD5.hexdigest(email)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
