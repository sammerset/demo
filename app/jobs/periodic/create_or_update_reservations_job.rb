# frozen_string_literal: true

module Periodic
  class CreateOrUpdateReservationsJob < ActiveJob::Base
    queue_as :default

    def perform
      Rails.logger.info 'Starting to fetch reservations...'
      FetchAndPersistLastTwoWeeksReservationsService.new.call
      Rails.logger.info 'Reservations had been successfully fetched and persisted!'
    end
  end
end
