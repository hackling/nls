class MetricsController < ApplicationController
  def index
  end

  private

  def chart_sales_vs_trades(date = Date.today)
    @sales_vs_trades ||= begin
      chart_data_hash = Hash.new{ |h, k| h[k] = [] }
      data = HourlyTransactionSummary.hours_for_day(date)

      data.each do |date_label, groupings|
        hours_for_row = Hash.new(0)

        groupings.each do |grouping|
          hours_for_row[grouping.transaction_type] = grouping.total
        end

        chart_data_hash[:labels] << date_label.strftime('%l:%M %P %a %d %b %Y')
        Transaction::TRANSACTION_TYPES.each do |type|
          chart_data_hash[type] << hours_for_row[type].to_i
        end
      end

      chart_data_hash
    end
  end
  helper_method :chart_sales_vs_trades

  def chart_sales_by_seller(date = Date.today)
    @sales_by_seller ||= begin
      chart_data_hash = Hash.new{ |h, k| h[k] = [] }
      data = HourlySellerSalesSummary.hours_for_day(date)

      data.each do |date_label, groupings|
        hours_for_row = Hash.new(0)

        groupings.each do |grouping|
          hours_for_row[grouping.seller_id] = grouping.total
        end

        chart_data_hash[:labels] << date_label.strftime('%l:%M %P %a %d %b %Y')
        Seller.all.each do |seller|
          chart_data_hash[seller.name] << hours_for_row[seller.id].to_i
        end
      end

      chart_data_hash
    end
  end
  helper_method :chart_sales_by_seller

  def data_sets
    output = ''
    chart_data = chart_sales_by_seller

    # output += "labels : #{chart_data[:labels]},"

    sellers = chart_data.keys - [:labels]
    # output += "datasets : ["

    colours = cross([0, 128])
    sellers.each_with_index do |seller, index|
      colours_array = colours[index].join(',')
      output += "{
        fillColor : \"rgba(#{colours_array},0.5)\",
        strokeColor : \"rgba(#{colours_array},1)\",
        pointColor : \"rgba(#{colours_array},1)\",
        pointStrokeColor : \"#fff\",
        data : #{chart_data[seller]}
      },"
    end
    output += output[0..(output.length-2)]
  end
  helper_method :data_sets

  def cross values, n = 3
    return [[]] * values.size if n == 0
    cross(values, n-1).each_with_object([]) do |e, arr|
      values.each do |value|
        arr << (e + [value])
      end
    end
  end
end

