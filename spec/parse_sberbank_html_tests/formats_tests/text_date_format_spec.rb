# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Formats::TextDateFormat do
  describe '#parse' do
    let(:settings) { { today: Time.utc(2011, 10, 10, 0, 0, 0) } }
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.parse '' }
      it { expect(result).to eq(nil) }
    end
    
    context 'when not empty' do
      let(:result) { subject.settings = settings; subject.parse '23.07' }
      it { expect(result).to eq(Time.utc(2011, 7, 23, 0, 0, 0)) }
    end
  end
end
