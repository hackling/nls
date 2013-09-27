class SalesController < InheritedResources::Base
  def new
    build_resource
    transaction_types = %w(Selling Trading)
    transaction_types.each do |tt|
      Seller.find_each do |seller|
        resource.transactions.build :seller => seller, :transaction_type => tt
      end
    end
    if store = Seller.find_by_name('Store')
      resource.transactions.build :seller => store, :transaction_type => 'Buying'
    end
  end
end
