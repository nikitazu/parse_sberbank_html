# encoding: utf-8
require 'parse_sberbank_html'
require 'spec_helper'

class FailingFormat
  attr_accessor :settings
  
  def parse value
    raise 'Failure'
  end
end # FailingFormat

describe ParseSberbankHtml::DataConverter do
  converter = ParseSberbankHtml::DataConverter.new
  describe '#convert' do
    context 'when single target' do
      source = { name: 'Mike' }
      target = { }
      formats = { person: ParseSberbankHtml::Formats::CopyFormat.new }
      converter.settings = { source: :name, target: :person, formats: formats }
      converter.convert source, target
      it { expect(target).to eq({ person: 'Mike' }) }
    end
    
    context 'when fails' do
      source = { name: 'Mike' }
      target = { }
      formats = { person: FailingFormat.new }
      converter.settings = { source: :name, target: :person, formats: formats }
      converter.convert source, target
      it { expect(target).to eq({ person: nil, errors: { person: :name } }) }
    end
  end
end
