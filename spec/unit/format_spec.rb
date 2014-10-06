require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Biggs::Format do
  describe ".find" do
    context "known country with format" do
      subject { Biggs::Format.find("cn") }

      it 'should be a Biggs::Format' do
        expect(subject).to be_kind_of(Biggs::Format)
      end

      it 'should determine country_name' do
        expect(subject.country_name).to eq("China")
      end

      it 'should determine iso_code' do
        expect(subject.iso_code).to eq("cn")
      end

      it 'should determine format_string' do
        expect(subject.format_string).to eq("{{recipient}}\n{{street}}\n{{zip}} {{city}} {{state}}\n{{country}}")
      end

    end
    
    context "known country with unknown format" do
      subject { Biggs::Format.find("af") }

      it 'should be a Biggs::Format' do
        expect(subject).to be_kind_of(Biggs::Format)
      end

      it 'should determine country_name' do
        expect(subject.country_name).to eq("Afghanistan")
      end

      it 'should determine iso_code' do
        expect(subject.iso_code).to eq("af")
      end

      it 'should determine format_string' do
        expect(subject.format_string).to be_nil
      end
      
    end
    
    context "unknown country" do
      subject { Biggs::Format.find("xx") }

      it 'should be a Biggs::Format' do
        expect(subject).to be_kind_of(Biggs::Format)
      end

      it 'should determine country_name' do
        expect(subject.country_name).to be_nil
      end

      it 'should determine iso_code' do
        expect(subject.iso_code).to eq("xx")
      end

      it 'should determine format_string' do
        expect(subject.format_string).to be_nil
      end

      # its(:country_name){ should eql(nil) }
      # its(:iso_code){ should eql("xx") }
      # its(:format_string){ should eql(nil) }
    end
  end
end