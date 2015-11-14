# encoding: utf-8
module ParseSberbankHtml
  module Formats
    class DecimalFormat
      attr_accessor :settings
      
      def parse str
        value = 0.00
        unless str.nil? or str.empty? then
          self.settings[:thousands_separators].each { |s| str.sub! s, '' }
          str.match /(\d+[\.|,]\d+)/ do |m|
            value = m[0].to_f
          end
        end
        value
      end
    end
  end
end