# frozen_string_literal: true
require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:customer_name, :address, :orders_count) }

    context "when attributes are missing" do
      %i[customer_name address orders_count].each do |attribute|
        it "is invalid without #{attribute}" do
          customer = build(:customer, attribute => nil)
          expect(customer).not_to be_valid
        end
      end
    end

    context "when attributes have incorrect data types" do 
      it "is invalid if customer_name is not a string" do
        customer = build(:customer, customer_name: 123)
        expect(customer).not_to be_valid
      end

      it "is invalid if address is not a string" do
        customer = build(:customer, address: 456)
        expect(customer).not_to be_valid
      end

      it "is invalid if orders_count is not an integer" do
        customer = build(:customer, orders_count: "abc")
        expect(customer).not_to be_valid
      end
    end

    context "when attributes are correct" do
      subject { create(:customer) }
      it { expect(subject).to be_valid }
    end
  end
end
