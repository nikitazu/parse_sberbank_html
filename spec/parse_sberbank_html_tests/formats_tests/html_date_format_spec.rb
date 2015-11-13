# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Formats::HtmlDateFormat do
  describe '#parse' do
    let(:settings) { { today: Time.utc(2011, 10, 10, 0, 0, 0) } }
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.parse '' }
      it { expect(result).to eq(nil) }
    end
    
    context 'when not empty' do
      let(:result) { subject.settings = settings; subject.parse "19АВГ" }
      it { expect(result).to eq(Time.utc(2011, 8, 19, 0, 0, 0)) }
    end
  end
end
