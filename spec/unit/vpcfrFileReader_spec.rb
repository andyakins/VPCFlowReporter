require_relative '../../app/vpcfrFileReader'

module VPCFR

  columnNames = ['version','accountid','interfaceid','srcaddr','dstaddr',
      'srcport','dstport','protocol','packets','bytes','start','end',
      'action','logstatus']

  RSpec.describe 'A correct file reader' do

    it 'can read in a proper file and parse it into an array of hashes' do
      reader = VPCFRFileReader.new(columnNames)
      reader.source = 'sample.dat'
      result = reader.read
      expect(result).to be_instance_of(Array)
      expect(result[0]).to be_instance_of(Hash)
      expect(result[0]["action"]).to eq("ACCEPT")
      expect(result[1]["action"]).to eq("REJECT")
      expect(result.length).to eq(60)
    end

    it 'will fail on not having the source available' do
      reader = VPCFRFileReader.new(columnNames)
      reader.source = 'badname.dat'
        reader.read

    end

  end

end
