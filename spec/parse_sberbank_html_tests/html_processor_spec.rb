# encoding: utf-8
require 'parse_sberbank_html'
require 'spec_helper'

describe ParseSberbankHtml::HtmlProcessor do
  let(:settings) { {
    today: Time.utc(2011, 10, 10, 0, 0, 0),
    currencies: { "RUR" => :rub },
    minus_signs: [ 'CR' ],
    thousands_separators: [ ' ' ] }
  }
  
  describe '#process' do
    let(:debit_transfer) { { 
      title: "VANIL DKH SANKT-PETERBURG RUS", 
      date: "19АВГ", 
      amount: "123.00 RUR" }
    }
    
    let(:credit_transfer) { { 
      title: "POS GASTRONOM 811 2 SANKT-PETERBU RUS", 
      date: "22АВГ", 
      amount: "4567.89CR RUR" }
    }
    
    let(:input) { { transfers: [ debit_transfer, credit_transfer ] } }
    
    context 'when empty' do
      let(:result) { subject.process nil }
      it { expect(result[:transfers]).to have(0).item }
    end
    
    context 'when not empty' do
      let(:result) { subject.settings = settings; subject.process input }
      it { expect(result[:transfers]).to match_array([
        { title: "VANIL DKH SANKT-PETERBURG RUS",
          date: Time.utc(2011, 8, 19, 0, 0, 0),
          amount: 123.00,
          currency: :rub,
          type: :debit,
          data: debit_transfer },
        { title: "POS GASTRONOM 811 2 SANKT-PETERBU RUS",
          date: Time.utc(2011, 8, 22, 0, 0, 0),
          amount: 4567.89,
          currency: :rub,
          type: :credit,
          data: credit_transfer }])
      }
    end
  end
end
