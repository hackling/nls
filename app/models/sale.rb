class Sale < ActiveRecord::Base
  has_many :transactions, :dependent => :destroy
  accepts_nested_attributes_for :transactions, :reject_if => proc { |attr| attr['amount'].to_f <= 0 }

  scope :order_by_time, order('created_at DESC')

  def transaction_totals
    totals = Hash[Transaction::TRANSACTION_TYPES.map { |key| [key, 0] }]
    totals.merge! self.transactions.group(:transaction_type).sum(:amount)
    totals
  end

  def transaction_totals_flash_message
    output = 'Transaction Processed - '
    transaction_totals.each do |type, amount|
      output += "#{type} - $#{amount}    "
    end
    output
  end

  #add to string method for transaction totals

  # TODO: spec me
  def transaction_for type, seller
    transactions.find { |t| t.transaction_type == type && t.seller == seller }
  end
end
