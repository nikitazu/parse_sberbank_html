# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Formats::AmountTypeFormat do
  describe '#parse' do
    let(:settings) { { minus_signs: [ '-', '−' ] } }
    
    context 'when nil' do
      let(:result) { subject.settings = settings; subject.parse nil }
      it { expect(result).to eq(nil) }
    end
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.parse '' }
      it { expect(result).to eq(nil) }
    end
    
    context 'when debit' do
      let(:result) { subject.settings = settings; subject.parse "80 000,00 руб." }
      it { expect(result).to eq(:debit) }
    end
  
    context 'when credit' do
      let(:result) { subject.settings = settings; subject.parse "−3 000,00 руб." }
      it { expect(result).to eq(:credit) }
    end
  end
end
