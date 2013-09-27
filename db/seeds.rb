time_in_past = DateTime.now - 1.hour

nick = Seller.create(:name => 'Nick')
will = Seller.create(:name => 'Will')
store = Seller.create(:name => 'Store')
trading = Seller.create(:name => 'Trade')

first_sale = Sale.create(:created_at => time_in_past)
second_sale = Sale.create

first_sale.transactions.create! :transaction_type => 'Selling', :amount => 42, :seller => nick, :created_at => time_in_past
first_sale.transactions.create! :transaction_type => 'Selling', :amount => 53, :seller => will, :created_at => time_in_past
first_sale.transactions.create! :transaction_type => 'Buying', :amount => 30, :seller => store, :created_at => time_in_past

second_sale.transactions.create! :transaction_type => 'Trading', :amount => 15, :seller => nick
second_sale.transactions.create! :transaction_type => 'Trading', :amount => 20, :seller => will
second_sale.transactions.create! :transaction_type => 'Selling', :amount => 70, :seller => nick
