class Seller < ActiveRecord::Base
  has_many :transactions

  validates_presence_of :name
  validates_uniqueness_of :name

  def total_contributions
    if store?
      transactions.purchases.sum(:amount)
    else
      transactions.trades.sum(:amount)
    end
  end

  # TODO: spec me
  def self.store
    Seller.where(name: 'Store').first_or_create!
  end

  def store?
    name == "Store"
  end

  scope :partners, -> { where('name <> ?', 'Store') }

  # TODO: spec me
  def self.for_sale_form
    [store] + partners
  end
end
