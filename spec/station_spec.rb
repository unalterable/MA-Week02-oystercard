require "station"

describe Station do
  subject(:station) { described_class.new("Vauxhall", 2) }

  it "has a name" do
    expect(station.name).to eq "Vauxhall"
  end

  it "has a zone" do
    expect(station.zone).to eq 2
  end
end
