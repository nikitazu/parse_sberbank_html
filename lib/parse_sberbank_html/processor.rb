# encoding: utf-8
module ParseSberbankHtml
  class Processor
    def initialize
      @settings = nil
      @formats = nil
    end
    
    def settings
      @settings
    end
    
    def settings= value
      @settings = value
      @formats.values.each {|k| k.settings = value }
    end
    
    def process data
      transfers = []
      unless data.nil? or data[:transfers].nil?
        data[:transfers].each do |transfer|
          date = @formats[:date].parse transfer[:date]
          amount_type, amount_data = @formats[:type].parse transfer[:amount].strip
          amount_currency, amount_data = @formats[:currency].parse amount_data
          @settings[:thousands_separators].each { |s| amount_data.delete! s }
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
  
  class HtmlProcessor < Processor
    def initialize
      @formats = {
        date: ParseSberbankHtml::Formats::HtmlDateFormat.new,
        currency: ParseSberbankHtml::Formats::CurrencyFormat.new,
        type: ParseSberbankHtml::Formats::AmountTypeFormat.new
      }
    end
  end
  
  class TextProcessor < Processor
    def initialize
      @formats = {
        date: ParseSberbankHtml::Formats::TextDateFormat.new,
        currency: ParseSberbankHtml::Formats::CurrencyFormat.new,
        type: ParseSberbankHtml::Formats::AmountTypeFormat.new
      }
    end
  end
end # ParseSberbankHtml
