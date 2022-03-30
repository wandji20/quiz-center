module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String
    field :gravatar_url, String
    field :username, String

    def gravatar_url
      email = object&.email&.downcase || ''
      gravatar_id = Digest::MD5.hexdigest(email)
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=40"
    end
  end
end
