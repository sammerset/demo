# frozen_string_literal: true

module Errors
  class ValidationErrorEntity < ErrorEntity
    self.title = 'Validation Error'
    self.code = 422

    attribute :details, Types::String
  end
end
