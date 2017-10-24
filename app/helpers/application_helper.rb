module ApplicationHelper
  def money_string(value)
    number_to_currency(value/100, unit: "$")
  end
end
