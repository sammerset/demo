# frozen_string_literal: true

module Contracts
  module Reservations
    class PersistAll < ApplicationContract
      schema do
        required(:reservations).value(:array).each do
          hash do
            required(:source_id).filled(:integer)
            required(:check_in).filled(:date_time)
            required(:check_out).filled(:date_time)
            required(:price).filled(:decimal)
            required(:guest_name).filled(:string)
            required(:listing_id).filled(:integer)
            required(:status).filled(:string)
          end
        end
      end
    end
  end
end
