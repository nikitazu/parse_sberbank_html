# encoding: utf-8
module ParseSberbankHtml
  module Formats
    class AmountTypeFormat
      attr_accessor :settings
      
      def parse str
        type = nil
        unless str.nil? or str.empty? then
          if self.settings[:minus_signs].any? { |s| not str.sub!(s, '').nil? } then
            type = :credit
          else
            type = :debit
          end
        end
        return type
      end
    end
  end
end