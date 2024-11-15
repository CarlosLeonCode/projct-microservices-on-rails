# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  rescue_from ActiveRecord::RecordNotFound, with: ->(exception) { handle_error(exception, :not_found) }
  rescue_from ActiveRecord::RecordInvalid, ArgumentError, StandardError, with: ->(e) { handle_error(e, :unprocessable_entity) }

  private

  def handle_error(exception, status)
    json_response(message: exception, response: nil, status: status)
  end
end
