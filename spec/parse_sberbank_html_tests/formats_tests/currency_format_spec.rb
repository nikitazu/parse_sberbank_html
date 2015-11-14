# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Formats::CurrencyFormat do
  describe '#parse' do
    let(:settings) { { currencies: { "руб." => :rub } } }
    
    context 'when nil' do
      let(:result) { subject.settings = settings; subject.parse nil }
      it { expect(result).to eq(nil) }
    end
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.parse '' }
      it { expect(result).to eq(nil) }
    end
    
    context 'when not empty' do
      let(:result) { subject.settings = settings; subject.parse "80 000,00 руб." }
      it { expect(result).to eq(:rub) }
    end
  end
end
