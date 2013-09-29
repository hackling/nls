class ContributionSection < SitePrism::Section
  element :name, 'th.name'
  element :contribution, 'td.contribution'
end

class ContributionPage < SitePrism::Page
  set_url "/contributions"

  sections :seller_contributions, ContributionSection, 'tr.contribution-data'

  def contribution_for name
    BigDecimal.new contribution_section_for(name).contribution.text
  end

  def contribution_section_for name
    seller_contributions.find do |sc|
      sc.name.text == name
    end
  end
end
