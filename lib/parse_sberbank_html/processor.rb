# encoding: utf-8
module ParseSberbankHtml
  class Processor
    attr_accessor :settings
    
    def process data
      transfers = []
      data[:transfers].each do |transfer|
        year = self.settings[:today].year
        date_data = transfer[:date].split(".")
        date_day = date_data[0].to_i
        date_month = date_data[1].to_i
        amount_data = transfer[:amount].strip
        
        minus_signs = self.settings[:minus_signs]
        if minus_signs.any? { |s| amount_data.include? s } then
          amount_type = :credit
          minus_signs.each { |s| amount_data.delete! s }
        else
          amount_type = :debit
        end
        
        amount_currency_key = self.settings[:currencies].keys.select { |k| amount_data.include? k }.first
        amount_currency = self.settings[:currencies][amount_currency_key]
        amount_data.delete! amount_currency_key
        amount_data.strip!
        
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
      { transfers: transfers }
    end
  end # Processor
end # ParseSberbankHtml
