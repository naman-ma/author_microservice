require 'httparty'

class UserVerificationService
    def self.verify_token(token)
    @options = {
        headers: {
            'Authorization' => "Bearer #{token}",
            'Content-Type' => 'application/json'
        }
    }
    # Send a request to the User microservice's token verification endpoint
    response = HTTParty.post('http://192.168.1.108:3000/verify_token', headers: @options[:headers] , body: { token: token })
    response
    end
end