Given(/^The store exists$/) do
  app.store
end

Given(/^A seller named "(.*?)"$/) do |name|
  Seller.create! name: name
end

When(/^"(.*?)" trades for \$(\d+) worth of cards for \$([\d.]+) of his cards$/) do |seller, value_gained, value_given|
  app.sales.trade(seller, value_given)
end

# Process a hash and transform the values into BigDecimals,
# removing "$" signs
def bd_hash hash
  Hash[
    hash.map do |k, v|
      [k, BigDecimal.new(v.gsub("$",''))]
    end
  ]
end

Then(/^The contributions should be$/) do |table|
  expect(app.contributions_hash).to eq bd_hash(table.rows_hash)
end

When(/^The store buys \$(\d+) worth of cards for \$(\d+)$/) do |value_gained, money_offered|
  app.sales.buy money_offered
end

When(/^The store sells \$(\d+) worth of cards$/) do |money_gained|
  app.sales.sell 'Store', money_gained
end

Then(/^The cash profit is \$(\d+)$/) do |expected_profit|
  expect(app.profit).to eq BigDecimal.new(expected_profit)
end

Then(/^The profit is distributed$/) do |table|
  expect(app.profit_distribution).to eq bd_hash(table.rows_hash)
end

When(/^"(.*?)" (sells|trades|buys) \$(\d+)$/) do |seller, action, amount|
  app.sales.enter_amount(seller, action, amount)
end

Then(/^the total (sold|traded|bought) should be \$(\d+)$/) do |action, amount|
  expect(app.sales.total_for action).to eq amount
end

When(/^I go to the selling page$/) do
  app.sales.load
end
