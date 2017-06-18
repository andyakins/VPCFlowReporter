require_relative '../../app/vpcfrFileWriter'

module VPCFR

  def setupOutputFile
  end

  RSpec.describe 'A correct file writer' do

    it 'can write a string to a new file' do
      writer = VPCFRFileWriter.new
      writer.destination = 'test_output.txt'

    end

  end
end
