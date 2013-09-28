class Seller < ActiveRecord::Base
  has_many :transactions

  validates_presence_of :name

  def total_contributions
    if store?
      transactions.purchases.sum(:amount)
    else
      transactions.trades.sum(:amount)
    end
  end

  def store?
    name == "Store"
  end
end
