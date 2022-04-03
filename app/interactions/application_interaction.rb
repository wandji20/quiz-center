class ApplicationInteraction < ActiveInteraction::Base
  set_callback :execute, :after, :raise_error

  private
  def invalid?
    errors.any?
  end

  def raise_error
    raise GraphQL::ExecutionError, errors if invalid?
  end
end
