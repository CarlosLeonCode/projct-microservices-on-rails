# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Customers", type: :request do
  describe "GET /api/v1/customers/:id" do
    context "when the customer exists" do
      subject(:customer) { create(:customer) }

      it "returns a success response" do
        get "/api/v1/customers/#{customer.id}"
        expect(response).to have_http_status :ok
      end

      it "returns the correct customer" do
        get "/api/v1/customers/#{customer.id}"
        json_response = JSON.parse(response.body)
        data = json_response["response"]
        
        expect(data["customer_name"]).to eq(customer.customer_name)
        expect(data["address"]).to eq(customer.address)
        expect(data["orders_count"]).to eq(customer.orders_count)
      end
    end

    context "when customer does not exist" do
      it "returns not_found" do
        get "/api/v1/customers/1"
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:not_found)
        expect(json_response["response"]).to eq(nil)
      end
    end
  end
end
