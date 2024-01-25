require_relative '../lib/fake_crypto'

describe "tmp_hash method" do 
  it "Dont be empty" do 
    expect(make_hash("","")).to eq({})
  end
end