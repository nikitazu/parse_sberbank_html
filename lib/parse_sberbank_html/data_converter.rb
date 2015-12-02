# encoding: utf-8

module ParseSberbankHtml
  class DataConverter
    attr_accessor :settings
    
    def convert source, target
      source_key = self.settings[:source]
      target_key = self.settings[:target]
      source_value = source[source_key]
      target_value = nil
      begin
        target_value = self.settings[:formats][target_key].parse source_value
      rescue
        target[:errors] = {} if target[:errors].nil?
        target[:errors][target_key] = source_key
      end
      target[target_key] = target_value
    end
  end # DataConverter
end # ParseSberbankHtml
