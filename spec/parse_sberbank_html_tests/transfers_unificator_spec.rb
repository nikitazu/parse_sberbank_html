# encoding: utf-8
require 'parse_sberbank_html'
require 'spec_helper'

describe ParseSberbankHtml::TransfersUnificator do
  describe '#unify' do
    let(:accounts) {
      { '(fooz|rooh)' => 'Debit Card',
        'daah' => 'Credit Card' }
    }
    let(:settings) {
      { accounts: accounts }
    }
    let(:input) {
      { transfers: [ 
        { title: 'Fooz' },
        { title: 'Rooh' },
        { title: 'Daah' },
        { title: 'Fooz' },
        { title: 'Oops' }, ]
      }
    }
    
    context 'when empty' do
      let(:result) { subject.settings = settings; subject.unify nil }
      it { expect(result[:transfers]).to have(0).item }
    end
    
    context 'when not empty' do
      let(:result) { subject.settings = settings; subject.unify input }
      it { expect(result[:transfers][0]).to eq({
          target: 'Debit Card',
          transfer: { title: 'Fooz' }
        })
      }
      it { expect(result[:transfers][1]).to eq({
          target: 'Debit Card',
          transfer: { title: 'Rooh' }
        })
      }
      it { expect(result[:transfers][2]).to eq({
          target: 'Credit Card',
          transfer: { title: 'Daah' }
        })
      }
      it { expect(result[:transfers][3]).to eq({
          target: 'Debit Card',
          transfer: { title: 'Fooz' }
        })
      }
      it { expect(result[:transfers][4]).to eq({
          target: nil,
          transfer: { title: 'Oops' }
        })
      }
    end
  end
end
