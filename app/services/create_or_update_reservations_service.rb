# frozen_string_literal: true

class CreateOrUpdateReservationsService
  include Interactor

  delegate :params, to: :context

  def call
    validate
    create_or_update_reservations
  end

  private

  def validate
    if validation.success?
      @sanitized_params = validation.to_h
    else
      context.fail! error: Errors::ValidationErrorEntity.new(details: validation.errors.to_h)
    end
  end

  def validation
    @_validation ||= Contracts::Reservations::PersistAll.new.call(
      reservations: params
    )
  end

  def create_or_update_reservations
    Reservation.upsert_all(@sanitized_params[:reservations], unique_by: :source_id)
  end
end
