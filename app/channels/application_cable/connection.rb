module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      self.current_user = AuthorizeApiRequest.call(request.headers)[:user]
    end
  end
end
