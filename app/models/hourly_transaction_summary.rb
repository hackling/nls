class HourlyTransactionSummary < ActiveRecord::Base
  is_view

  def self.hours_for_day(date)
    start_time = Time.now.beginning_of_day
    summary = HourlyTransactionSummary.where(:hour => start_time...start_time+1.day).group_by(&:hour)
    hours = (0..23).map { |i| start_time + i.hours }
    Hash[hours.map { |hour| [hour, summary[hour] || []] }]
  end
end
