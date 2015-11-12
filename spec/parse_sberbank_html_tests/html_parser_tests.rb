# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::HtmlParser do
  let(:parser) { ParseSberbankHtml::HtmlParser.new }
  
  describe '#parse' do
    it 'handles empty input' do
      result = parser.parse ""
      result[:transfers].length.should == 0
    end
  end
end
