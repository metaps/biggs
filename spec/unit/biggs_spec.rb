require File.join(File.dirname(__FILE__), '..', 'spec_helper')

FAKE_ATTR_WITH_STATE = {:state => "STATE", :city => "CITY", :zip => 12345, :street => "STREET", :recipient => "MR. X"}
FAKE_ATTR_WO_STATE = {:city => "CITY", :zip => 12345, :street => "STREET", :recipient => "MR. X"}

describe Biggs::Formatter, "with defaults" do
  
  before { @biggs = Biggs::Formatter.new }
  
  it "should format to us format" do
    expect(@biggs.format('us', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\nCITY STATE 12345\nUnited States of America")
  end
  
  it "should format to de format" do
    expect(@biggs.format('de', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nGermany")
  end
  
  it "should format to british format" do
    expect(@biggs.format('gb', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\nCITY\nSTATE\n12345\nUnited Kingdom")
  end

  it "should format to japanese format" do
    expect(@biggs.format('jp', FAKE_ATTR_WITH_STATE)).to eq("Japan\n〒12345\nSTATE CITY STREET\nMR. X")
  end
  
  it "should format to fr format" do
    expect(@biggs.format('fr', FAKE_ATTR_WO_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nFrance")
  end
  
  it "should format to fr format if country_code unknown and there is no STATE given" do
    expect(@biggs.format('unknown', FAKE_ATTR_WO_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nunknown")
  end
  
  it "should format to us format if country_code unknown and there is no STATE given" do
    expect(@biggs.format('unknown', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\nCITY STATE 12345\nunknown")
  end
  
  it "should format to no(rwegian) format" do
    expect(@biggs.format('no', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nNorway")
  end

  it "should format to NC format" do
    expect(@biggs.format('nc', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nNew Caledonia")
  end
  
  it "should use country name if Country is known but format not" do
    expect(@biggs.format('af', FAKE_ATTR_WO_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nAfghanistan")
  end
  
  it "should use ISO Code if Country is unknown" do
    expect(@biggs.format('xx', FAKE_ATTR_WO_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nxx")
  end
  
end

describe Biggs, "with options" do
  
  describe "blank_country_on de" do
    before { @biggs = Biggs::Formatter.new(:blank_country_on => 'de') }
    
    it "should have blank country in 'de' address" do
      expect(@biggs.format('de', FAKE_ATTR_WO_STATE)).to eq("MR. X\nSTREET\n12345 CITY")
    end
    
    it "should have country in 'fr' address" do
      expect(@biggs.format('fr', FAKE_ATTR_WO_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nFrance")
    end
    
  end
  
  describe "blank_country_on multiple (US,de)" do
    before { @biggs = Biggs::Formatter.new(:blank_country_on => ['US', "de"]) }
    
    it "should have blank country in 'us' address" do
      expect(@biggs.format('us', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\nCITY STATE 12345")
    end
    
    it "should have country in 'fr' address" do
      expect(@biggs.format('fr', FAKE_ATTR_WITH_STATE)).to eq("MR. X\nSTREET\n12345 CITY\nFrance")
    end
    
  end
  
end