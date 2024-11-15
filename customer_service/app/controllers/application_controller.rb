class ApplicationController < ActionController::API
  include Response
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ArgumentError, with: :handle_argument_error

  private
  
  def record_not_found(exception)
    json_response({ error: exception }, status: :not_found)
  end

  def record_invalid(exception)
    json_response({ error: exception }, status: :unprocessable_entity)
  end

  def handle_argument_error(exception)
    json_response({ error: exception }, status: :unprocessable_entity)
  end
end
