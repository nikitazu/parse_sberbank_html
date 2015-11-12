# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::HtmlParser do
  let(:parser) { ParseSberbankHtml::HtmlParser.new }
  let(:html) { File.read("#{File.dirname(__FILE__)}/data/html_parser_input.html") }
  
  describe '#parse' do
    it 'handles empty input' do
      result = parser.parse ""
      result[:transfers].length.should == 0
    end
    
    it 'handles html input' do
      result = parser.parse html
      result[:transfers].length.should == 1
      result[:transfers][0].should == {
        title: "SUSHI SHOP SANKT-PETERBU RUS",
        date: "17АВГ",
        amount: "123.00CR RUR" }
    end
  end
end
