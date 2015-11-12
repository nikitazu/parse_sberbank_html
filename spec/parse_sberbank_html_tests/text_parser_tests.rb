# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::TextParser do
  describe '#parse' do
    context 'when empty' do
      let(:result) { subject.parse '' }
      it { expect(result[:transfers]).to have(0).item }
    end
    
    context 'when no headers' do
      text = "
  ATM RUS SANKT-PETERBU ATM 123456	20.02 	−3 000,00 руб.	 
  BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02 	80 000,00 руб."

      let(:result) { subject.parse text }

      it { expect(result[:transfers]).to have(2).item }
      it { expect(result[:transfers][0]).to eq({ 
        title: "ATM RUS SANKT-PETERBU ATM 123456", 
        date: "20.02", 
        amount: "−3 000,00 руб." })
      }
      it { expect(result[:transfers][1]).to eq({ 
        title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
        date: "20.02", 
        amount: "80 000,00 руб." })
      }
    end
    
    context 'when has headers' do
      text = "
  ВИД ОПЕРАЦИИ, МЕСТО СОВЕРШЕНИЯ	ДАТА	СУММА
  ATM RUS SANKT-PETERBU ATM 239492	20.02	−20 000,00 руб.
  BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02	+10 000,00 руб."

      let(:result) { subject.parse text }

      it { expect(result[:transfers]).to have(2).item }
      it { expect(result[:transfers][0]).to eq({ 
        title: "ATM RUS SANKT-PETERBU ATM 239492", 
        date: "20.02", 
        amount: "−20 000,00 руб." })
      }
      it { expect(result[:transfers][1]).to eq({ 
        title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
        date: "20.02", 
        amount: "+10 000,00 руб." })
      }
    end
  end
end
