class Seller < ActiveRecord::Base
  has_many :transactions

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.all_total_contributions
    contributions =  []
    Seller.all.each do |seller|
      contributions << [seller.name, seller.total_contributions]
    end
    Hash[contributions]
  end

  def self.total_contributions
    Transaction.where(seller_id: Seller.the_store).purchases.sum(:amount) +
    Transaction.where(seller_id: Seller.partners).trades.sum(:amount)
  end

  def self.all_total_contributions_with_percentages
    total = total_contributions
    Seller.all.map do |seller|
      [
        seller.name,
        seller.total_contributions,
        seller.total_contributions / total * 100,
      ]
    end
  end

  def total_contributions
    if store?
      transactions.purchases.sum(:amount)
    else
      transactions.trades.sum(:amount)
    end
  end

  def self.store
    Seller.where(name: 'Store').first_or_create!
  end

  def store?
    name == "Store"
  end

  scope :partners, -> { where('name <> ?', 'Store') }
  scope :the_store, -> { where(name: 'Store') }

  def self.for_sale_form
    [store] + partners
  end
end
