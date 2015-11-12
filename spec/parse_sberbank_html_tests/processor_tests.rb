# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Processor do
  describe '#process' do
    let(:settings) { {
      today: Time.utc(2011, 10, 10, 0, 0, 0),
      currencies: { "руб." => :rub },
      minus_signs: [ '-', '−' ],
      thousands_separators: [ ' ' ] }
    }
    
    let(:debit_transfer) { { 
      title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
      date: "15.07", 
      amount: "80 000,00 руб." }
    }
    
    let(:credit_transfer) { { 
      title: "ATM RUS SANKT-PETERBU ATM 123456", 
      date: "20.02", 
      amount: "−3 000,00 руб." }
    }
    
    context 'when empty' do
      let(:result) { subject.process nil }
      it { result[:transfers].should have(0).item }
    end
    
    context 'when debit' do
      let(:result) { subject.settings = settings; subject.process({ transfers: [ debit_transfer ] }) }
      it { result[:transfers].should have(1).item }
      it { result[:transfers][0].should == {
          title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA",
          date: Time.utc(2011, 07, 15, 0, 0, 0),
          amount: 80000.00,
          currency: :rub,
          type: :debit,
          data: {
            title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA",
            date: "15.07", 
            amount: "80 000,00 руб." } }
      }
    end
    
    context 'when credit' do
      let(:result) { subject.settings = settings; subject.process({ transfers: [ credit_transfer ] }) }
      it { result[:transfers].should have(1).item }
      it { result[:transfers][0].should == {
          title: "ATM RUS SANKT-PETERBU ATM 123456",
          date: Time.utc(2011, 02, 20, 0, 0, 0),
          amount: 3000.00,
          currency: :rub,
          type: :credit,
          data: {
            title: "ATM RUS SANKT-PETERBU ATM 123456",
            date: "20.02", 
            amount: "−3 000,00 руб." } }
      }
    end
  end
end
