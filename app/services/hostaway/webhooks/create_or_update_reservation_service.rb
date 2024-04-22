# frozen_string_literal: true

module Hostaway
  module Webhooks
    class CreateOrUpdateReservationService
      include Interactor

      delegate :params, to: :context

      def call
        create_or_update_reservations
      end

      private

      def normalized_entries
        Hostaway::Webhooks::ReservationsMapper.normalize_all(params)
      end

      def create_or_update_reservations
        result = CreateOrUpdateReservationsService.call(params: normalized_entries)

        return if result.success?

        context.fail! error: result.error
      end
    end
  end
end
