class UserSerializer < ActiveModel::Serializer
  attributes :name, :unanswered_questions, :avatar
  
  def name
    object.name
  end

  def avatar
    # add gravatar image link
  end
end
