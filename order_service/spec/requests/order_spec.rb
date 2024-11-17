# frozen_string_literal: true
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "Orders", type: :request do
  describe "GET /api/v1/orders" do
    context "when orders exists" do
      let!(:order) { create(:order) }
      before(:example) { get "/api/v1/orders" }

      it { expect(response).to have_http_status :ok }
      it { expect(JSON.parse(response.body)["response"].first["id"]).to eq(order.id) }
      it { expect(JSON.parse(response.body)["response"].length).to eq(1) }
    end

    context "when does not exist orders" do
      before(:example) { get "/api/v1/orders" }

      it { expect(response).to have_http_status :ok }
      it { expect(JSON.parse(response.body)["response"].length).to eq(0) }
    end
  end

  describe "GET /api/v1/orders/:id" do
    context "when order exist" do
      let!(:order) { create(:order) }
      before(:example) { get "/api/v1/orders/#{order.id}" }

      it { expect(response).to have_http_status :ok }
      it { expect(JSON.parse(response.body)["response"]["id"]).to eq(order.id) }
    end

    context "when does not exist" do
      before(:example) { get "/api/v1/orders/#{rand(2..5)}" }

      it { expect(response).to have_http_status :not_found }
      it { expect(JSON.parse(response.body)["response"]).to eq(nil) }
    end
  end

  describe "POST /api/v1/orders" do
    let(:customer_id) { 1 }
    let(:customer_service_path) { "http://localhost:3001/api/v1/customers/#{customer_id}" }
    let(:valid_params) { create(:order, customer_id: customer_id) }
    let(:invalid_params) { create(:order, price: nil, quantity: nil) }

    context "when customer exists in the external service" do
      before do
        ENV['CUSTOMER_SERVICE_API_PATH'] = "http://localhost:3001/api/v1"
        stub_request(:get, customer_service_path)
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Faraday v2.12.1'
            }
          )
          .to_return(
            status: 200, 
            body: { 
              customer_name: "Cassatt",
              address: "12703 Christine Turnpike",
              orders_count: 5
            }.to_json, 
            headers: { 'Content-Type': 'application/json' }
          )

        post "/api/v1/orders", params: valid_params, as: :json
      end

      it "creates a new order" do
        
        binding.pry
        
        # expect(response).to have_http_status(:created)
        # parsed_response = JSON.parse(response.body)
        # expect(parsed_response["response"]["order"]["product_name"]).to eq(valid_params.product_name)
        # expect(parsed_response["response"]["order"]["quantity"]).to eq(valid_params.quantity)
        # expect(parsed_response["response"]["order"]["price"].to_f).to eq(valid_params.price)
        # expect(parsed_response["response"]["order"]["status"]).to eq(valid_params.status)
        # expect(parsed_response["response"]["order"]["customer_id"]).to eq(valid_params.customer_id)
      end
    end
  end
end
