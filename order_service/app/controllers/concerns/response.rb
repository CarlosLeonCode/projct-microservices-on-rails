module Response
  extend ActiveSupport::Concern

  def json_response(response:, message: nil, status: :ok)
    render json: {
      message: message,
      response: response
    }, status: status
  end
end
