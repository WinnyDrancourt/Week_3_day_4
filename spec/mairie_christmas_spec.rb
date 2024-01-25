require_relative '../lib/mairie_christmas'

describe "Townhall email method" do
  it "Should take one mail" do
    expect(find_mail(["https://annuaire-des-mairies.com/95/ambleville.html"])).to be_kind_of(Array)
  end
end

describe "Townhall name method" do
  it "Should take name" do
    expect(find_town_name(["https://annuaire-des-mairies.com/95/ambleville.html"])).to eq(["AMBLEVILLE"])
  end
end