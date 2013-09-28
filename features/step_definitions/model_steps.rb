Given(/^A seller named "(.*?)"$/) do |name|
  Seller.create! name: name
end

When(/^"(.*?)" trades for \$(\d+) worth of cards for \$([\d.]+) of his cards$/) do |seller, value_gained, value_given|
  seller = Seller.where(name: seller).first or fail "can't find seller named: #{seller}"
  sale = Sale.new
  sale.transactions.build seller: seller, transaction_type: "Trading", amount: value_given
  sale.save!
end

Then(/^The contributions should be$/) do |table|
  contributions = Hash[
    Seller.all.map do |seller|
      [seller.name, seller.transactions.acquisitions.map(&:amount).sum]
    end
  ]

  expect(contributions).to eq Hash[
    table.rows_hash.map do |k, v|
      [k, BigDecimal.new(v)]
    end
  ]
end

When(/^The store buys \$(\d+) worth of cards for \$(\d+)$/) do |value_gained, money_offered|
  seller = Seller.where(name: 'Store').first_or_create!
  sale = Sale.new 
  sale.transactions.build seller: seller, transaction_type: 'Buying', amount: money_offered
  #sale.transactions.build seller: seller, transaction_type: 'Card', amount: value_gained
  sale.save!
  #TODO: Include valued gained
end

Then(/^The card distribution is$/) do |table|
  # table is a Cucumber::Ast::Table
  #pending # express the regexp above with the code you wish you had
end

When(/^The store sells \$(\d+) worth of cards$/) do |money_gained|
  seller = Seller.where(name: 'Store').first_or_create!
  sale = Sale.new 
  sale.transactions.build seller: seller, transaction_type: 'Selling', amount: money_gained
  sale.save!
end

Then(/^The cash profit is \$(\d+)$/) do |expected_profit|
  seller = Seller.where(name: 'Store').first_or_create!
  profit = seller.transactions.sales.sum(:amount) - seller.transactions.purchases.sum(:amount)
  expect(profit).to eq BigDecimal.new(expected_profit)
end


def percentages
  contributions = Seller.all.map { |x| [x.name, x.total_contributions] }
  total_contributions = contributions.map(&:last).sum
  percentages = contributions.map do |name, contribution|
    [ name, (contribution / total_contributions) ]
  end
end

def distribution_of profit
  Hash[
  percentages.map do |name, percent|
    [name, (profit * percent).round(2)]
  end
  ]
end

Then(/^The profit is distributed$/) do |table|
  seller = Seller.where(name: 'Store').first_or_create!
  profit = seller.transactions.sales.sum(:amount) - seller.transactions.purchases.sum(:amount)

  expect(distribution_of(profit)).to eq Hash[
    table.rows_hash.map do |k, v|
      [k, BigDecimal.new(v[1..-1])]
    end
  ]
end
