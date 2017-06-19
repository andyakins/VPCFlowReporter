require 'fileutils'
require_relative '../../app/vpcfrFileReader'
require_relative '../vpcfrTestData'

module VPCFR
RSpec.describe 'A correct file reader' do

  badfile = 'data/readerTestBad.dat'

  it 'can read in a proper file and parse it into an array of hashes' do
    reader = VPCFRFileReader.new(VPCFRTestData.columnNames)
    reader.source = 'data/sample.dat'
    result = reader.read
    expect(result).to be_instance_of(Array)
    expect(result[0]).to be_instance_of(Hash)
    expect(result[0]["action"]).to eq("ACCEPT")
    expect(result[1]["action"]).to eq("REJECT")
    expect(result.length).to eq(60)
  end

  it 'will fail on not having the source file available' do
    if File.exist?(badfile) # Need to make sure the file isn't there
      FileUtils.rm(badfile)
    end
    reader = VPCFRFileReader.new(VPCFRTestData.columnNames)
    reader.source = badfile
    expect {
      reader.read
    }.to raise_error(Errno::ENOENT)
  end

end
end
