require 'spec_helper'

describe Amazomania do
  it 'has a version number' do
    expect(Amazomania::VERSION).not_to be nil
  end

  # oh... poor test...
  it 'return array' do
    asin = "B01N06V253"
    expect(Amazomania.data(asin).class).to eq(Array)
  end
end
