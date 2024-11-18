class CustomerNotFound < StandardError
  def initialize(message = "Customer not was found")
    super(message)
  end
end
