# encoding: utf-8
module ParseSberbankHtml
  class TextProcessor < Processor
    def initialize
      @formats = {
        date: ParseSberbankHtml::Formats::TextDateFormat.new,
        currency: ParseSberbankHtml::Formats::TextCurrencyFormat.new,
        type: ParseSberbankHtml::Formats::TextTypeFormat.new
      }
    end
  end
end # ParseSberbankHtml
