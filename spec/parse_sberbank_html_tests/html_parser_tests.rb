# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::HtmlParser do
  it "should parse html" do
    html = "
<html>
<head>
</head>
<body>
TODO
</body>
</html>
    "
    parser = ParseSberbankHtml::HtmlParser.new

    result = parser.parse html

    result.should_not == nil
    result[:transfers].should_not == nil
    result[:transfers].length.should == 0
  end
end
