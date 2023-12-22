module ApplicationHelper
    #formating price to standard currency format
    def format_price(amount)
        number_to_currency(amount, unit: "$", precision: 2)
    end
end
