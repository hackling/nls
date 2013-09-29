module ApplicationHelper
  def navbar_li text, options
    css_class = current_page?(options) ? "active" : ""
    content_tag :li, class: css_class do
      navbar_link_to text, options
    end
  end

  def sale_time sale
    sale.created_at.strftime("%a %l:%M %P")
  end

  private

  def navbar_link_to text, path
    link_to_unless_current text, path do
      content_tag :a, text
    end
  end

  def money_or_your_dash amount
    (amount && amount > 0) && number_to_currency(amount) || "&ndash;".html_safe
  end

  def money_for transactions
    money_or_your_dash transactions.first.try(:amount)
  end
end
