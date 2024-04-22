# frozen_string_literal: true

module Hostaway
  class Client
    HOSTAWAY_URL = ENV.fetch('HOSTAWAY_URL')
    HOSTAWAY_AUTH_URL = "#{HOSTAWAY_URL}/v1/accessTokens"
    HOSTAWAY_RESERVATION_URL = "#{HOSTAWAY_URL}/v1/reservations"

    Result = Struct.new(:success?, :error_message, :data)

    def initialize(opts = {})
      @auth_token = auth_token.data
      @opts = opts
    end

    def find_all(params = {})
      dto do
        RestClient.get(HOSTAWAY_RESERVATION_URL, { params: params, **auth_headers })
      end
    end

    private

    def auth_token
      dto 'access_token' do
        RestClient.post(
          HOSTAWAY_AUTH_URL,
          {
            grant_type: 'client_credentials',
            client_id: ENV.fetch('HOSTAWAY_AUTH_TOKEN'),
            client_secret: ENV.fetch('HOSTAWAY_AUTH_SECRET'),
            scope: 'general'
          }
        )
      end
    end

    def auth_headers
      { Authorization: "Bearer #{@auth_token}" }
    end

    def dto(result_key = 'result')
      result = JSON.parse(yield)[result_key]

      Result.new(true, nil, result)
    rescue RuntimeError => e
      Rails.logger.error e

      Result.new(false, e, nil)
    end
  end
end
