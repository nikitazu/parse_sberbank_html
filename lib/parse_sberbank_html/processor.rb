# encoding: utf-8
module ParseSberbankHtml
  class Processor
    def initialize
      @settings = nil
      @formats = nil
      @converters = []
    end
    
    def settings
      @settings
    end
    
    def settings= value
      @settings = value
      @formats.values.each {|k| k.settings = value }
      create_converter source: :title, target: :title, formats: @formats
      create_converter source: :date, target: :date, formats: @formats
      create_converter source: :amount, target: :type, formats: @formats
      create_converter source: :amount, target: :currency, formats: @formats
      create_converter source: :amount, target: :amount, formats: @formats
    end
    
    def create_converter settings
      x = DataConverter.new
      x.settings = settings
      @converters << x
    end
    
    def process data
      transfers = []
      unless data.nil? or data[:transfers].nil?
        data[:transfers].each do |transfer|
          tr = { }
          @converters.each do |c|
            c.convert transfer, tr
            tr[:data] = transfer
          end
          transfers.push tr
        end
      end
      { transfers: transfers }
    end
    
  end # Processor
  
  class HtmlProcessor < Processor
    def initialize
      super
      @formats = {
        title: Formats::CopyFormat.new,
        date: Formats::HtmlDateFormat.new,
        currency: Formats::CurrencyFormat.new,
        type: Formats::AmountTypeFormat.new,
        amount: Formats::DecimalFormat.new,
      }
    end
  end # HtmlProcessor
  
  class TextProcessor < Processor
    def initialize
      super
      @formats = {
        title: Formats::CopyFormat.new,
        date: Formats::TextDateFormat.new,
        currency: Formats::CurrencyFormat.new,
        type: Formats::AmountTypeFormat.new,
        amount: Formats::DecimalFormat.new,
      }
    end
  end # TextProcessor
end # ParseSberbankHtml
