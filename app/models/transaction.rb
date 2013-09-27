class Transaction < ActiveRecord::Base
  TRANSACTION_TYPES = %w[Buying Selling Trading]

  belongs_to :seller

  validates_presence_of :transaction_type, :seller, :amount
end
