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

class SalesPage < SitePrism::Page
  set_url "/sales/new"

  sections :transactions, TransactionSection, '[data-transaction-type]'

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
end
