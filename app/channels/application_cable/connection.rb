module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = AuthorizeCableRequest.call(request.params[:token])
    end
  end
end
