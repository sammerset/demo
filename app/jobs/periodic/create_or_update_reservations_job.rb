# frozen_string_literal: true

module Periodic
  class CreateOrUpdateReservationsJob < ActiveJob::Base
    queue_as :default

    def perform
      Rails.logger.info 'Starting to fetch reservations...'

      result = Hostaway::FetchAndPersistLastTwoWeeksReservationsService.call

      if result.success?
        Rails.logger.info 'Reservations had been successfully fetched and persisted!'
      else
        raise "Fetch reservations error: #{e}"
      end
    end
  end
end
