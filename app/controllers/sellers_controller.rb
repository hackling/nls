class SellersController < InheritedResources::Base
  def contributions
    @contributions = Seller.all_total_contributions
  end
end
