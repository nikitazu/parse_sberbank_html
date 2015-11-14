# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Formats::DecimalFormat do
  describe '#parse' do
    let(:settings) { { thousands_separators: [ ' ' ] } }
    
    context 'when nil' do
      let(:result) { subject.settings = settings; subject.parse nil }
      it { expect(result).to eq(0) }
    end
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.parse '' }
      it { expect(result).to eq(0) }
    end
    
    context 'when not empty comma' do
      let(:result) { subject.settings = settings; subject.parse "80 000,00 руб." }
      it { expect(result).to eq(80000.00) }
    end
    
    context 'when not empty dot' do
      let(:result) { subject.settings = settings; subject.parse "80 000.00 руб." }
      it { expect(result).to eq(80000.00) }
    end
    
    context 'when not empty with trash' do
      let(:result) { subject.settings = settings; subject.parse "foo80 000,00bar руб." }
      it { expect(result).to eq(80000.00) }
    end
  end
end
