# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::TextParser do
  it "should parse text" do
    text = "
ATM RUS SANKT-PETERBU ATM 123456	20.02 	−3 000,00 руб.	 
ATM RUS SANKT-PETERBU ATM 456123	20.02 	−5 000,00 руб.	 
BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02 	80 000,00 руб."
    parser = ParseSberbankHtml::TextParser.new

    result = parser.parse text

    result.should_not == nil
    result[:transfers].should_not == nil
    result[:transfers].length.should == 3

    result[:transfers][0].should == { 
      title: "ATM RUS SANKT-PETERBU ATM 123456", 
      date: "20.02", 
      amount: "−3 000,00 руб." }

    result[:transfers][1].should == { 
      title: "ATM RUS SANKT-PETERBU ATM 456123", 
      date: "20.02", 
      amount: "−5 000,00 руб." }

    result[:transfers][2].should == { 
      title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
      date: "20.02", 
      amount: "80 000,00 руб." }
  end
  
  it "should parse text with headers" do
    text = "
ВИД ОПЕРАЦИИ, МЕСТО СОВЕРШЕНИЯ	ДАТА	СУММА
ATM RUS SANKT-PETERBU ATM 239492	20.02	−20 000,00 руб.
BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02	+10 000,00 руб.
CH Debit RUS MOSCOW SBOL	21.03	−2 300,21 руб.
CH Debit RUS Visa Direct Ololo Bank Card2Card	05.04	−2 000,00 руб.
BP Billing Transfer RUS AUTOPLATEZH	05.04	−123,45 руб."
    parser = ParseSberbankHtml::TextParser.new

    result = parser.parse text

    result.should_not == nil
    result[:transfers].should_not == nil
    result[:transfers].length.should == 5

    result[:transfers][0].should == { 
      title: "ATM RUS SANKT-PETERBU ATM 239492", 
      date: "20.02", 
      amount: "−20 000,00 руб." }

    result[:transfers][1].should == { 
      title: "BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA", 
      date: "20.02", 
      amount: "+10 000,00 руб." }

    result[:transfers][2].should == { 
      title: "CH Debit RUS MOSCOW SBOL", 
      date: "21.03", 
      amount: "−2 300,21 руб." }

    result[:transfers][3].should == { 
      title: "CH Debit RUS Visa Direct Ololo Bank Card2Card", 
      date: "05.04", 
      amount: "−2 000,00 руб." }

    result[:transfers][4].should == { 
      title: "BP Billing Transfer RUS AUTOPLATEZH", 
      date: "05.04", 
      amount: "−123,45 руб." }
  end
end
