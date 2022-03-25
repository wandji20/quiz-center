module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # calls AuthorizeCableRequest to authenticate user JWT token
    def connect
      self.current_user = AuthorizeCableRequest.call(request.params[:token])
    end
  end
end
