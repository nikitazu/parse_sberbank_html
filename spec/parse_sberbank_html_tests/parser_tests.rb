# encoding: utf-8
require 'parse_sberbank_html'

describe ParseSberbankHtml::Parser do
  it "should parse plain text" do
    text = "
ATM RUS SANKT-PETERBU ATM 239492	20.02 	−3 000,00 руб.	 
ATM RUS SANKT-PETERBU ATM 239498	20.02 	−5 000,00 руб.	 
BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02 	80 000,00 руб."
    parser = ParseSberbankHtml::Parser.new
    
    result = parser.parse_plain_text text
    
    result.should_not == nil
    transfers = result[:transfers]
    transfers.should_not == nil
    transfers.length.should == 3
  end
  
  it "should parse plain text with headers" do
    text = "
ВИД ОПЕРАЦИИ, МЕСТО СОВЕРШЕНИЯ	ДАТА	СУММА
ATM RUS SANKT-PETERBU ATM 239492	20.02	−20 000,00 руб.
ATM RUS SANKT-PETERBU ATM 239498	20.02	−30 000,00 руб.
ATM RUS SANKT-PETERBU ATM 239492	20.02	−2 000,00 руб.
BP Acct - Card RUS SBERBANK ONL@IN VKLAD-KARTA	20.02	+10 000,00 руб.
ATM RUS SANKT-PETERBU ATM 239498	20.02	−11 000,00 руб.
CH Debit RUS MOSCOW SBOL	21.03	−2 300,21 руб.
CH Debit RUS Visa Direct Ololo Bank Card2Card	05.04	−2 000,00 руб.
BP Billing Transfer RUS AUTOPLATEZH	05.04	−123,45 руб.
CH Debit RUS MOSCOW SBOL	09.04	−2 345,67 руб.
CH Debit RUS MOSCOW SBOL	10.04	−321,02 руб."
    parser = ParseSberbankHtml::Parser.new
    
    result = parser.parse_plain_text text
    
    result.should_not == nil
    transfers = result[:transfers]
    transfers.should_not == nil
    transfers.length.should == 10
  end
end
