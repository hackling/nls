module KnowsHowToSell
  class App
    def store
      @store ||= Seller.store
    end

    def sales
      @sales ||= Sales.new
    end

    def profit
      store.transactions.sales.sum(:amount) - store.transactions.purchases.sum(:amount)
    end

    def contributions
      Hash[
        Seller.all.map do |seller|
          [seller.name, seller.transactions.acquisitions.map(&:amount).sum]
        end
      ]
    end

    def profit_distribution
      seller = Seller.store
      profit = seller.transactions.sales.sum(:amount) - seller.transactions.purchases.sum(:amount)

      distribution_of(profit)
    end

    private

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
  end

  class Sales
    def trade seller_name, amount
      seller = Seller.where(name: seller_name).first or fail "can't find seller named: #{seller}"
      sale = Sale.new
      sale.transactions.build seller: seller, transaction_type: "Trading", amount: amount
      sale.save!
    end

    def buy money_offered
      sale = Sale.new
      sale.transactions.build seller: Seller.store, transaction_type: 'Buying', amount: money_offered
      sale.save!
    end

    def sell seller_name, money_gained
      seller = Seller.where(name: seller_name).first_or_create!
      sale = Sale.new
      sale.transactions.build seller: seller, transaction_type: 'Selling', amount: money_gained
      sale.save!
    end
  end

  def app
    @app ||= App.new
  end
end

World(KnowsHowToSell)
