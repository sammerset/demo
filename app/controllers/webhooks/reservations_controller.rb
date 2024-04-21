# frozen_string_literal: true

module Webhooks
  class ReservationsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def handle
      CreateOrUpdateReservationService.new.call(params: params.permit!)
    end
  end
end
