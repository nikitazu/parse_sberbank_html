# encoding: utf-8
module ParseSberbankHtml
  class Parser
    def parse_html html
      transfers = []
      { transfers: transfers }
    end
    
    def parse_plain_text text
      transfers = []
      text.strip.split("\n").reject { |line| headers? line }.each do |transfer|
        data = transfer.split("\t")
        transfers.push(
          title: data[0].strip,
          date: data[1].strip,
          amount: data[2].strip)
      end
      { transfers: transfers }
    end
    
  private
    def headers? line
      line == "ВИД ОПЕРАЦИИ, МЕСТО СОВЕРШЕНИЯ	ДАТА	СУММА"
    end
  end
end
