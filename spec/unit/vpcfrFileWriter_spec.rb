require 'fileutils'
require_relative '../../app/vpcfrFileWriter'


module VPCFR

  destination = 'data/writerTest.dat'
  testdata ="{\n  \"172.16.8.1\": 4,\n  \"172.16.8.2\": 3\n}"

  RSpec.describe 'A correct file writer' do

  it 'can write a string to a new file' do
    if File.exist?(destination)
      FileUtils.rm(destination)
    end
    writer = VPCFRFileWriter.new
    writer.destination = destination
    writer.write(testdata)
    expect(File.exist?(destination)).to eq(true)
    expect(File.read(destination)).to eq(testdata)
  end

end
end
