# frozen_string_literal: true

class Reservation < ApplicationRecord
  validates :guest_name, uniqueness: { scope: %i[check_in check_out] }
end
