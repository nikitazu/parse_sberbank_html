# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::TextParser do
  let(:parser) { ParseSberbankHtml::TextParser.new }
  
  describe '#parse' do
    context 'when empty' do
      it { parser.parse("")[:transfers].length.should == 0 }
    end
    
    context 'when no headers' do
      text = "
  ATM RUS SANKT-PETERBU ATM 123456	20.02 	−3 000,00 руб.	 
  BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02 	80 000,00 руб."

      subject(:result) { parser.parse(text) }

      it { result[:transfers].length.should == 2 }
      it { result[:transfers][0].should == { 
        title: "ATM RUS SANKT-PETERBU ATM 123456", 
        date: "20.02", 
        amount: "−3 000,00 руб." }
      }
      it { result[:transfers][1].should == { 
        title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
        date: "20.02", 
        amount: "80 000,00 руб." }
      }
    end
    
    context 'when has headers' do
      text = "
  ВИД ОПЕРАЦИИ, МЕСТО СОВЕРШЕНИЯ	ДАТА	СУММА
  ATM RUS SANKT-PETERBU ATM 239492	20.02	−20 000,00 руб.
  BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02	+10 000,00 руб."

      subject(:result) { parser.parse(text) }

      it { result[:transfers].length.should == 2 }
      it { result[:transfers][0].should == { 
        title: "ATM RUS SANKT-PETERBU ATM 239492", 
        date: "20.02", 
        amount: "−20 000,00 руб." }
      }
      it { result[:transfers][1].should == { 
        title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
        date: "20.02", 
        amount: "+10 000,00 руб." }
      }
    end
  end
end
