# frozen_string_literal: true

class Reservation < ApplicationRecord
  validates :source_id, uniqueness: true
end
