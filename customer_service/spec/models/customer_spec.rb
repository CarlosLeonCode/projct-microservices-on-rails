# frozen_string_literal: true

require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:orders_count) }

    context "when attributes are missing" do
      %i[customer_name address orders_count].each do |attribute|
        it "is invalid without #{attribute}" do
          expect(build(:customer, attribute => nil)).not_to be_valid
        end
      end
    end

    context "when attributes have incorrect data types" do 
      it { expect(build(:customer, customer_name: 123)).not_to be_valid }
      it { expect(build(:customer, address: 21.2)).not_to be_valid }
      it { expect(build(:customer, orders_count: "abc")).not_to be_valid }
    end

    context "when attributes are correct" do
      it { expect(create(:customer)).to be_valid }
    end
  end
end
