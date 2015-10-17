require 'parse_sberbank_html'

describe ParseSberbankHtml::Parser do
  it "should parse html" do
    parser = ParseSberbankHtml::Parser.new
    result = parser.parse_html ""
    result.should == nil
  end
end
