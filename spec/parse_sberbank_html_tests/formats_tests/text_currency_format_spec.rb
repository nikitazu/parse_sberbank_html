# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Formats::TextCurrencyFormat do
  describe '#parse' do
    let(:settings) { { currencies: { "руб." => :rub } } }
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.parse '' }
      it { expect(result).to match_array([nil, '']) }
    end
    
    context 'when not empty' do
      let(:result) { subject.settings = settings; subject.parse "80 000,00 руб." }
      it { expect(result).to match_array([:rub, "80 000,00"]) }
    end
  end
end
