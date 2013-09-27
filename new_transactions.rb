(0..99).each do |x|
  sale = Sale.new
  sale.save!
  seller_id = Seller.all.map(&:id).shuffle.pop
  hours = Random.new.rand * 10
  amount = Random.new.rand * 100
  Transaction.new(
    :seller_id => seller_id,
    :transaction_type => 'Selling',
    :created_at => Time.now - hours.hours,
    :amount => amount,
    :sale_id => (sale.id)
  ).save!
end
