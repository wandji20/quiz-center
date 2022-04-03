module Types
  class MutationType < Types::BaseObject
    field :create_authentication, mutation: Mutations::Authentication::CreateAuthentication, null: false
    
  end
end
