# frozen_string_literal: true

module Hostaway
  class FetchAndPersistLastTwoWeeksReservationsService
    include Interactor

    delegate :reservations, to: :context

    def call
      ActiveRecord::Base.transaction do
        fetch_reservations_data
        create_or_update_reservations
      end
    end

    after do
      context.reservations = @sanitized_params
    end

    private

    def fetch_reservations_data
      return if reservations_data_past_two_weeks.success?

      context.fail! error: Errors::InternalErrorEntity.new(details: reservations_data_past_two_weeks.error_message)
    end

    def reservations_attributes_past_two_weeks
      Hostaway::ReservationsMapper.normalize_all(reservations_data_past_two_weeks.data)
    end

    def reservations_data_past_two_weeks
      @_reservations_data_past_two_weeks ||= client.find_all(
        latestActivityStart: 2.weeks.ago,
        latestActivityEnd: Time.current
      )
    end

    def create_or_update_reservations
      result = CreateOrUpdateReservationsService.call(params: reservations_attributes_past_two_weeks)

      return if result.success?

      context.fail! error: result.error
    end

    def client
      @_client ||= Hostaway::Client.new
    end
  end
end
