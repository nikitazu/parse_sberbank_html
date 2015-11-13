# encoding: utf-8
module ParseSberbankHtml
  module Formats
    class TextTypeFormat
      attr_accessor :settings
      
      def parse str
        type = nil
        unless str.empty? then
          if self.settings[:minus_signs].any? { |s| not str.sub!(s, '').nil? } then
            type = :credit
          else
            type = :debit
          end
        end
        return type, str
      end
    end
  end
end