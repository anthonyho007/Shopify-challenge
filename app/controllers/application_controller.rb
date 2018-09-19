class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler

    before_action :validate_request
    attr_reader :current_shop

    private

    def validate_request
        @current_shop = (OauthRequest.new(request.headers).call)[:shop]
    end
end
