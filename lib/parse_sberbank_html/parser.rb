# encoding: utf-8
module ParseSberbankHtml
  class Parser
    def parse_html html
      transfers = []
      { transfers: transfers }
    end
    
    def parse_plain_text text
      transfers = text.strip.split("\n").reject { |line| headers? line }
      { transfers: transfers }
    end
    
  private
    def headers? line
      line == "ВИД ОПЕРАЦИИ, МЕСТО СОВЕРШЕНИЯ	ДАТА	СУММА"
    end
  end
end
