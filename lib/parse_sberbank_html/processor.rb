# encoding: utf-8
module ParseSberbankHtml
  class Processor
    attr_accessor :settings
    
    def initialize
      @formats = {
        date: ParseSberbankHtml::Formats::HtmlDateFormat.new,
        currency: ParseSberbankHtml::Formats::TextCurrencyFormat.new,
        type: ParseSberbankHtml::Formats::TextTypeFormat.new
      }
    end
    
    def process data
      @formats[:date].settings = self.settings
      @formats[:type].settings = self.settings
      @formats[:currency].settings = self.settings
      transfers = []
      unless data.nil? or data[:transfers].nil?
        data[:transfers].each do |transfer|
          date = @formats[:date].parse transfer[:date]
          amount_type, amount_data = @formats[:type].parse transfer[:amount].strip
          amount_currency, amount_data = @formats[:currency].parse amount_data
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
  end # Processor
end # ParseSberbankHtml
