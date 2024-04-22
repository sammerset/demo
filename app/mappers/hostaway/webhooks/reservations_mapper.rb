# frozen_string_literal: true

module Hostaway
  module Webhooks
    class ReservationsMapper
      extend HashMapper

      map from('/id'), to('/source_id')
      map from('/arrivalDate'), to('/check_in') { |v| DateTime.parse(v) }
      map from('/departureDate'), to('/check_out') { |v| DateTime.parse(v) }
      map from('/totalPrice'), to('/price') { |v| v.to_d }
      map from('/guestName'), to('/guest_name')
      map from('/listingMapId'), to('/listing_id')
      map from('/status'), to('/status')

      def self.normalize_all(input)
        input.map { |r| normalize(r) }
      end
    end
  end
end
