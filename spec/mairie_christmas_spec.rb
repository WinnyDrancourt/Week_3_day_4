require_relative '../lib/mairie_christmas'

describe "Townhall email method" do
  it "Should take one mail" do
    expect(find_mail(https://annuaire-des-mairies.com/95/saint-brice-sous-foret.html)).to eq("info@saintbrice95.fr")
  end
end