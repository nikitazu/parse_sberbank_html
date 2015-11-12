# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::HtmlParser do
  describe '#parse' do
    context 'when empty' do
      let(:result) { subject.parse '' }
      it { result[:transfers].length.should == 0 }
    end
    
    context 'when not empty' do
      let(:html) { File.read("#{File.dirname(__FILE__)}/data/html_parser_input.html") }
      let(:result) { subject.parse html }
      it { result[:transfers].length.should == 1 }
      it { result[:transfers][0].should == {
        title: "SUSHI SHOP SANKT-PETERBU RUS",
        date: "17АВГ",
        amount: "123.00CR RUR" }
      }
    end
  end
end
