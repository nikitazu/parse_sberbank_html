# encoding: utf-8
module ParseSberbankHtml
  class HtmlProcessor < Processor
    def initialize
      @formats = {
        date: ParseSberbankHtml::Formats::HtmlDateFormat.new,
        currency: ParseSberbankHtml::Formats::TextCurrencyFormat.new,
        type: ParseSberbankHtml::Formats::TextTypeFormat.new
      }
    end
  end
end # ParseSberbankHtml
