require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:product_name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }

    context "when attributes are missing" do
      %i[product_name quantity price status customer_id].each do |attribute|
        it "is invalid without #{attribute}" do
          order = build(:order, attribute => nil)
          expect(order).not_to be_valid
        end
      end
    end

    context "when attributes have incorrect data types" do 
      it { expect(build(:order, product_name: nil)).not_to be_valid }
      it { expect(build(:order, quantity: "some")).not_to be_valid }
      it { expect(build(:order, price: "some")).not_to be_valid }
      it { expect { Order.new(status: "some") }.to raise_error(ArgumentError, "'some' is not a valid status") }
      it { expect(build(:order, customer_id: "some")).not_to be_valid }
    end

    context "when attributes are correct" do
      it { expect(create(:order)).to be_valid }
    end
  end
end
