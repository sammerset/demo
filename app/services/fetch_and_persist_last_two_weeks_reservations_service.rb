# frozen_string_literal: true

class FetchAndPersistLastTwoWeeksReservationsService
  def call
    fetch_and_persist_reservations
  end

  private

  def fetch_and_persist_reservations
    return if past_2_weeks_reservations.empty?

    Reservation.upsert_all(past_2_weeks_reservations, unique_by: %w[guest_name check_in check_out])
  end

  def past_2_weeks_reservations
    @_past_2_weeks_reservations ||= client.fetch_all_reservations_entities(
      latestActivityStart: 2.weeks.ago,
      latestActivityEnd: Time.current
    )
  end

  def client
    Hostaway::Client.new
  end
end
