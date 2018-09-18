module ExceptionHandler
    extend ActiveSupport::Concern

    class AuthError < StandardError; end
    class TokenError < StandardError; end

    included do
        rescue_from ActiveRecord::RecordNotFound, with: :not_found_request
        
        rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_request

        rescue_from ExceptionHandler::TokenError, with: :unprocessable_request

        rescue_from ExceptionHandler::AuthError, with: :unauth_request
    end

    private
    def unprocessable_request(e)
        json_response({ message: e.message }, :unprocessable_entity)
    end

    def unauth_request(e)
        json_response({ message: e.message }, :unauthorized)
    end

    def not_found_request(e)
        json_response({ message: e.message }, :not_found)
    end
end
