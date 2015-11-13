# encoding: utf-8
module ParseSberbankHtml
  class HtmlProcessor < Processor
    def initialize
      @formats = {
        date: ParseSberbankHtml::Formats::HtmlDateFormat.new,
        currency: ParseSberbankHtml::Formats::CurrencyFormat.new,
        type: ParseSberbankHtml::Formats::AmountTypeFormat.new
      }
    end
  end
end # ParseSberbankHtml
