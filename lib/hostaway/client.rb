# frozen_string_literal: true

module Hostaway
  class Client
    HOSTAWAY_URL = ENV.fetch('HOSTAWAY_URL')
    HOSTAWAY_AUTH_URL = "#{HOSTAWAY_URL}/v1/accessTokens"
    HOSTAWAY_RESERVATION_URL = "#{HOSTAWAY_URL}/v1/reservations"

    attr_reader :opts

    def initialize(opts = {})
      @auth_token = auth_token
      @opts = opts
    end

    def fetch_all_reservations_entities(params = {})
      reservations_attributes(
        response do
          RestClient.get(HOSTAWAY_RESERVATION_URL, { params: params, **auth_headers })
        end
      )
    end

    private

    def auth_token
      response 'access_token' do
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

    def response(result_key = 'result')
      JSON.parse(yield)[result_key]
    rescue RuntimeError => e
      Rails.logger.error e
    end

    def reservations_attributes(api_reservations)
      api_reservations.map do |api_reservation|
        {
          check_in: api_reservation['arrivalDate'],
          check_out: api_reservation['departureDate'],
          price: api_reservation['totalPrice'],
          guest_name: api_reservation['guestName'],
          listing_id: api_reservation['listingMapId'],
          status: api_reservation['status']
        }
      end
    end
  end
end
