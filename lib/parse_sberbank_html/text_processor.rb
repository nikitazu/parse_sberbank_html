# encoding: utf-8
module ParseSberbankHtml
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
