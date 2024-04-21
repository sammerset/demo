# frozen_string_literal: true

class Reservation < ApplicationRecord
  validates :title, uniqueness: { scope: %i[check_in check_out] }
end
