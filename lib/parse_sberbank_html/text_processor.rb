# encoding: utf-8
module ParseSberbankHtml
  class TextProcessor
    attr_accessor :settings
    
    def get_amount_type value
      minus_signs = self.settings[:minus_signs]
      if minus_signs.any? { |s| value.include? s } then
        minus_signs.each { |s| value.delete! s }
        return :credit, value
      else
        return :debit, value
      end
    end
    
    def get_amount_currency value
      currencies = self.settings[:currencies]
      amount_currency_key = currencies.keys.select { |k| value.include? k }.first
      amount_currency = currencies[amount_currency_key]
      return amount_currency, value.delete(amount_currency_key).strip
    end
    
    def process data
      transfers = []
      unless data.nil? or data[:transfers].nil?
        data[:transfers].each do |transfer|
          year = self.settings[:today].year
          date_data = transfer[:date].split(".")
          date_day = date_data[0].to_i
          date_month = date_data[1].to_i
          
          amount_type, amount_data = self.get_amount_type transfer[:amount].strip
          amount_currency, amount_data = self.get_amount_currency amount_data

          self.settings[:thousands_separators].each { |s| amount_data.delete! s }

          amount_value = amount_data.to_f

          transfers.push(
            title: transfer[:title],
            date: Time.utc(year, date_month, date_day, 0, 0, 0),
            amount: amount_value,
            currency: amount_currency,
            type: amount_type,
            data: transfer)
        end
      end
      { transfers: transfers }
    end
  end # TextProcessor
end # ParseSberbankHtml
