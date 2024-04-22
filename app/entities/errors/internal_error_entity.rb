# frozen_string_literal: true

module Errors
  class InternalErrorEntity < ErrorEntity
    self.title = 'Internal Error'
    self.code = 500

    attribute :details, Types::String
  end
end
