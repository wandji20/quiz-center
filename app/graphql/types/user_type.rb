module Types
  class UserType < Types::BaseObject
    field :email, String, null: false,
                          description: 'unique users email'
    field :gravatar_url, String, null: false,
                                 description: 'user gravatar url'
    field :username, String,
          description: 'users username or null if not present'

    def gravatar_url
      email = object&.email&.downcase || ''
      gravatar_id = Digest::MD5.hexdigest(email)
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=40"
    end
  end
end
