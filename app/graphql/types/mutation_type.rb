module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::User::CreateUser
    field :create_authentication, mutation: Mutations::Authentication::CreateAuthentication
  end
end
