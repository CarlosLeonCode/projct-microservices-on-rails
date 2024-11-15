module Response
  extend ActiveSupport::Concern

  def json_response(response:, message: nil, status: :ok)
    render json: {
      message: message,
      response: response
    }, status: status
  end

  def serialize_collection(collection, serializer)
    ActiveModel::Serializer::CollectionSerializer.new(collection, serializer: serializer)
  end
end
