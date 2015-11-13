# encoding: utf-8
module ParseSberbankHtml
  class HtmlProcessor
    attr_accessor :settings
    
    def get_amount_type value
      if self.settings[:minus_signs].any? { |s| not value.sub!(s, '').nil? } then
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
    
    def get_date value
      year = self.settings[:today].year
      date_day = value[0, 2].to_i
      date_month = ['ЯНВ','ФЕВ','МАР','АПР','МАЙ','ИЮН','ИЮЛ','АВГ','СЕН','ОКТ','НОЯ','ДЕК'].find_index(value[2, 3]) + 1
      return Time.utc(year, date_month, date_day, 0, 0, 0)
    end
    
    def process data
      transfers = []
      unless data.nil? or data[:transfers].nil?
        data[:transfers].each do |transfer|
          date = self.get_date transfer[:date]
          amount_type, amount_data = self.get_amount_type transfer[:amount].strip
          amount_currency, amount_data = self.get_amount_currency amount_data
          self.settings[:thousands_separators].each { |s| amount_data.delete! s }
          amount_value = amount_data.to_f

          transfers.push(
            title: transfer[:title],
            date: date,
            amount: amount_value,
            currency: amount_currency,
            type: amount_type,
            data: transfer)
        end
      end
      { transfers: transfers }
    end
  end # HtmlProcessor
end # ParseSberbankHtml
