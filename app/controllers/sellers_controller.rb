class SellersController < InheritedResources::Base
  def contributions
    @contributions = Seller.all_total_contributions_with_percentages
  end
end
