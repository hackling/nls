class Transaction < ActiveRecord::Base
  TRANSACTION_TYPES = %w[Buying Selling Trading]

  belongs_to :seller

  validates_presence_of :transaction_type, :seller, :amount

  scope :trades, -> { where(transaction_type: 'Trading') }
  scope :sales, -> { where(transaction_type: 'Selling') }
  scope :purchases, -> { where(transaction_type: 'Buying') }
  scope :acquisitions, -> { where(transaction_type: %w[Trading Buying]) }
end
