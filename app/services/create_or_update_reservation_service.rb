# frozen_string_literal: true

class CreateOrUpdateReservationService
  attr_reader :params

  def call(params:)
    @params = params
    create_or_update_reservation
  end

  private

  def create_or_update_reservation
    Reservation.upsert(adopted_reservation_attributes, unique_by: %w[guest_name check_in check_out])
  end

  def adopted_reservation_attributes
    {
      check_in: @params['arrivalDate'],
      check_out: @params['departureDate'],
      price: @params['totalPrice'],
      guest_name: @params['guestName'],
      listing_id: @params['listingMapId'],
      status: @params['status']
    }
  end
end
