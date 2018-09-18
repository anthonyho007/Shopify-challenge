class ShopToken
    H_SECRET = Rails.application.credentials.secret_key_base 

    def self.encode(payload, expire = 6.hours.from_now)
        payload[:expire] = expire.to_i
        JWT.encode(payload, H_SECRET)
    end

    def self.decode(token)
        content = JWT.decode(token, H_SECRET)[0]
        HashWithIndifferentAccess.new content

        rescue JWT::DecodeError => e 
            raise ExceptionHandler::TokenError, e.message
    end
end
