# encoding: utf-8
require 'parse_sberbank_html'
require 'spec_helper'

describe ParseSberbankHtml::TextProcessor do
  let(:settings) { {
    today: Time.utc(2011, 10, 10, 0, 0, 0),
    currencies: { "руб." => :rub },
    minus_signs: [ '-', '−' ],
    thousands_separators: [ ' ' ] }
  }
  
  describe '#process' do
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
    
    let(:input) { { transfers: [ debit_transfer, credit_transfer ] } }
    
    context 'when empty' do
      let(:result) { subject.process nil }
      it { expect(result[:transfers]).to have(0).item }
    end
    
    context 'when not empty' do
      let(:result) { subject.settings = settings; subject.process input }
      it { expect(result[:transfers]).to match_array([
        { title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA",
          date: Time.utc(2011, 07, 15, 0, 0, 0),
          amount: 80000.00,
          currency: :rub,
          type: :debit,
          data: debit_transfer },
        { title: "ATM RUS SANKT-PETERBU ATM 123456",
          date: Time.utc(2011, 02, 20, 0, 0, 0),
          amount: 3000.00,
          currency: :rub,
          type: :credit,
          data: credit_transfer }])
      }
    end
  end
end
