# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Processor do
  it "should process transfers" do
    t1 = { 
      title: "ATM RUS SANKT-PETERBU ATM 123456", 
      date: "20.02", 
      amount: "−3 000,00 руб." }

    t2 = { 
      title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
      date: "15.07", 
      amount: "80 000,00 руб." }

    data = { transfers: [t1, t2] }
    
    processor = ParseSberbankHtml::Processor.new
    processor.settings = {
      today: Time.utc(2011, 10, 10, 0, 0, 0),
      currencies: { "руб." => :rub },
      minus_signs: [ '-', '−' ],
      thousands_separators: [ ' ' ]}
    
    result = processor.process data
    
    result.should_not == nil
    result[:transfers].should_not == nil
    result[:transfers].length.should == 2
    result[:transfers][0].should == {
      title: "ATM RUS SANKT-PETERBU ATM 123456",
      date: Time.utc(2011, 02, 20, 0, 0, 0),
      amount: 3000.00,
      currency: :rub,
      type: :credit,
      data: {
        title: "ATM RUS SANKT-PETERBU ATM 123456",
        date: "20.02", 
        amount: "−3 000,00 руб."
      }
    }
    result[:transfers][1].should == {
      title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA",
      date: Time.utc(2011, 07, 15, 0, 0, 0),
      amount: 80000.00,
      currency: :rub,
      type: :debit,
      data: {
        title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA",
        date: "15.07", 
        amount: "80 000,00 руб."
      }
    }
  end
end
