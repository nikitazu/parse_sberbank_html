# encoding: utf-8
require 'parse_sberbank_html'
require 'spec_helper'

describe ParseSberbankHtml::HtmlParser do
  describe '#parse' do
    context 'when empty' do
      let(:result) { subject.parse '' }
      it { expect(result[:transfers]).to have(0).item }
    end
    
    context 'when not empty' do
      let(:html) { File.read("#{File.dirname(__FILE__)}/data/html_parser_input.html") }
      let(:result) { subject.parse html }
      it { expect(result[:transfers]).to match_array([{
        title: "SUSHI SHOP SANKT-PETERBU RUS",
        date: "17АВГ",
        amount: "123.00CR RUR" }])
      }
    end
  end
end
