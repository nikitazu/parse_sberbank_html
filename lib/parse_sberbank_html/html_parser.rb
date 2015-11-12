# encoding: utf-8

require 'nokogiri'

module ParseSberbankHtml
  class HtmlParser
    def parse html
      transfers = []
      doc = Nokogiri::HTML html
      transfer_nodes = doc.css '.rowTrnData'
      transfer_nodes.each do |node|
        data_cells = node.css 'td'
        tr = { 
          title: data_cells[4].text,
          date: data_cells[1].text,
          amount: "#{data_cells[7].text} #{data_cells[5].text}" }
        transfers.push tr
      end
      { transfers: transfers }
    end
  end # HtmlParser
end # ParseSberbankHtml
