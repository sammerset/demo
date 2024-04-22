# frozen_string_literal: true

module Errors
  class ErrorEntity < ::BaseEntity
    attribute :id, Types::Integer
    attribute :check_in, Types::DateTime
  end
end
