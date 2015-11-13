# encoding: utf-8
module ParseSberbankHtml
  module Formats
    class HtmlDateFormat
      attr_accessor :settings
      
      def initialize
        @months = ['ЯНВ','ФЕВ','МАР','АПР','МАЙ','ИЮН','ИЮЛ','АВГ','СЕН','ОКТ','НОЯ','ДЕК']
      end
      
      def parse str
        date = nil
        unless str.empty? then
          date_month = @months.find_index(str[2, 3]) + 1
          date = Time.utc self.settings[:today].year, date_month, str[0, 2].to_i, 0, 0, 0
        end
        date
      end
    end
  end
end