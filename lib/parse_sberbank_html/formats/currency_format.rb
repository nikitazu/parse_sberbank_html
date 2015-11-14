# encoding: utf-8
module ParseSberbankHtml
  module Formats
    class CurrencyFormat
      attr_accessor :settings
      
      def parse str
        currency = nil
        unless str.nil? or str.empty? then
          currencies = self.settings[:currencies]
          key = currencies.keys.select { |k| str.include? k }.first
          currency = currencies[key]
          str.sub! key, ''
          str.strip!
        end
        return currency
      end
    end
  end
end