require_relative '../../app/vpcfrSTDOUTWriter'


module VPCFR

  destination = 'data/fileWriter.test'
  testdata ="{\n  \"172.16.8.1\": 4,\n  \"172.16.8.2\": 3\n}"

  # VPCFRSTDOUTWriter unit tests
  RSpec.describe 'A correct file writer' do

    # Basic write test. Note that the original STDOUT is saved, then
    # the $stdout variable is set to be a StringIO object so the output
    # can be confirmed, then after the test $stdout is restored.
    it 'will dump its output to STDOUT' do
      oldSTDOUT = $stdout
      begin
        $stdout = StringIO.new('','w')
        writer = VPCFRSTDOUTWriter.new
        writer.destination = destination # this is pointless, but we do it as its part of the normal operation
        writer.write(testdata)
        expect($stdout.string).to eq(testdata)
      ensure
        $stdout = oldSTDOUT
      end
    end
  end
end
