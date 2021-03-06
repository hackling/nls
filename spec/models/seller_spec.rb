require 'spec_helper'

def buy seller_name, amount
  seller = Seller.where(name: seller_name).first or fail "no seller: #{seller_name}"
  sale = Sale.new
  sale.transactions.build seller: seller, transaction_type: "Buying", amount: amount
  sale.save!
end

def sell seller_name, amount
  seller = Seller.where(name: seller_name).first or fail "no seller: #{seller_name}"
  sale = Sale.new
  sale.transactions.build seller: seller, transaction_type: "Selling", amount: amount
  sale.save!
end

def trade seller_name, amount
  seller = Seller.where(name: seller_name).first or fail "no seller: #{seller_name}"
  sale = Sale.new
  sale.transactions.build seller: seller, transaction_type: "Trading", amount: amount
  sale.save!
end

describe Seller do
  before(:each) do
    Seller.create! name: "Store"
    Seller.create! name: "Nick"
    Seller.create! name: "Will"
  end

  let(:store) { Seller.where(name: "Store").first }

  describe '.for_sale_form' do
    let(:will) { Seller.where(name: "Will").first }

    it 'should return in order with store first' do
      expect(Seller.for_sale_form.first).to eq store
      expect(Seller.for_sale_form.last).to eq will
    end
  end

  describe ".store?" do
    it "should be true for the Store" do
      expect(Seller.find_by_name("Store").store?).to be_true
    end

    it "should be false for the Store" do
      expect(Seller.find_by_name("Nick").store?).to be_false
    end
  end

  describe ".total_contributions" do
    before(:each) do
      buy "Store", 50
      trade "Store", 100
      sell "Nick", 50
      trade "Nick", 100
      trade "Nick", 25
      sell "Will", 100
      trade "Will", 25
    end

    subject { Seller.where(name: seller_name).first.total_contributions }

    context "all_total_contributions" do
      it 'should return a hash with all contributions' do
        expect(Seller.all_total_contributions).to eq( {
          "Store" => BigDecimal.new("50.0"),
          "Nick" => BigDecimal.new("125.0"),
          "Will" => BigDecimal.new("25.0"),
          } )
      end
    end

    def bd s
      BigDecimal.new s
    end

    context ".all_total_contributions_with_percentages" do
      it "should return an array with contributions and percentages" do
        expect(Seller.all_total_contributions_with_percentages).to eq([
          ["Store", bd("50.0"),  bd("25")],
          ["Nick",  bd("125.0"), bd("62.5")],
          ["Will",  bd("25.0"),  bd("12.5")],
        ])
      end
    end

    context "the Store" do
      let(:seller_name) { "Store" }

      it { should eq BigDecimal.new("50.0") }
    end

    context "Nick" do
      let(:seller_name) { "Nick" }

      it { should eq BigDecimal.new("125") }
    end

    context "Will" do
      let(:seller_name) { "Will" }

      it { should eq BigDecimal.new("25") }
    end
  end
end
