# encoding: utf-8
module ParseSberbankHtml
  class TransfersUnificator
    attr_accessor :settings
    
    def unify data
      result = { transfers: [] }
      unless data.nil? or data[:transfers].nil?
        regexes = []
        accounts = []
        self.settings[:accounts].each do |key, value|
          regexes.push Regexp.new(key, Regexp::IGNORECASE)
          accounts.push value
        end
        data[:transfers].each do |transfer|
          index = 0
          target = nil
          regexes.any? do |re|
            re.match transfer[:title] do |m|
              target = accounts[index]
            end
            index = index + 1
            not target.nil?
          end
          result[:transfers].push({ target: target, transfer: transfer })
        end
      end
      result
    end
  end
end
