module Types
  class MutationType < Types::BaseObject
    field :update_answered_question, mutation: Mutations::AnsweredQuestion::UpdateAnsweredQuestion
    field :create_answered_question, mutation: Mutations::AnsweredQuestion::CreateAnsweredQuestion
    field :create_user, mutation: Mutations::User::CreateUser
    field :create_authentication, mutation: Mutations::Authentication::CreateAuthentication
  end
end
