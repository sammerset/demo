# frozen_string_literal: true

class BaseEntity < Dry::Struct
  class << self
    attr_accessor :code, :title
  end

  transform_keys(&:to_sym)
end
