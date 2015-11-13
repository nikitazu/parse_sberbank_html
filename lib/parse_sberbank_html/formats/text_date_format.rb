# encoding: utf-8
module ParseSberbankHtml
  module Formats
    class TextDateFormat
      attr_accessor :settings
      
      def parse str
        date = nil
        unless str.empty? then
          date_data = str.split(".")
          date = Time.utc self.settings[:today].year, date_data[1].to_i, date_data[0].to_i, 0, 0, 0
        end
        date
      end
    end
  end
end