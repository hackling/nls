class TransactionSection < SitePrism::Section
  def update_amount amount
    root_element.find(:css, "input[type=number]").set amount
  end

  def transaction_type
    root_element[:"data-transaction-type"]
  end

  def seller_name
    root_element[:"data-seller"]
  end
end

class TransactionTotalSection < SitePrism::Section
  element :total, '.total'
end

class SalesPage < SitePrism::Page
  set_url "/sales/new"

  sections :transactions, TransactionSection, '[data-transaction-type]'
  sections :transaction_totals, TransactionTotalSection, '.total'

  element :buying_total, ".total.buying"
  element :selling_total, ".total.selling"
  element :trading_total, ".total.trading"

  def enter_amount seller_name, action, amount
    case action
    when 'trades'
      transaction_for(seller_name, "Trading").update_amount amount
    when 'sells'
      transaction_for(seller_name, "Selling").update_amount amount
    when 'buys'
      if seller_name != Seller.store.name
        fail 'Only the store can buy cards'
      else
        transaction_for("Store", "Buying").update_amount amount
      end
    end
  end

  def trade seller, amount
    load
    transaction_for(seller, "Trading").update_amount amount
    click_button "Create Sale"
  end

  def buy amount
    load
    transaction_for("Store", "Buying").update_amount amount
    click_button "Create Sale"
  end

  def sell seller, amount
    load
    transaction_for(seller, "Selling").update_amount amount
    click_button "Create Sale"
  end

  def transaction_for seller, type
    transactions.find do |tc|
      tc.transaction_type == type &&
        tc.seller_name == seller
    end
  end

  def total_for action
    case action
    when 'sold'
      selling_total.text
    when 'traded'
      trading_total.text
    when 'bought'
      buying_total.text
    end
  end
end
