# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Formats::TextTypeFormat do
  describe '#parse' do
    let(:settings) { { minus_signs: [ '-', '−' ] } }
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.parse '' }
      it { expect(result).to match_array([nil, '']) }
    end
    
    context 'when debit' do
      let(:result) { subject.settings = settings; subject.parse "80 000,00 руб." }
      it { expect(result).to match_array([:debit, "80 000,00 руб."]) }
    end
  
    context 'when credit' do
      let(:result) { subject.settings = settings; subject.parse "−3 000,00 руб." }
      it { expect(result).to match_array([:credit, "3 000,00 руб."]) }
    end
  end
end
