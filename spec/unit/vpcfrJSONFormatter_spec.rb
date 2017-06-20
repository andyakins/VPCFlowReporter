require_relative '../../app/vpcfrJSONFormatter'
require_relative '../vpcfrTestData'

module VPCFR

  # VPCFRJSONFormatter unit tests
  RSpec.describe 'A correct json formatter' do

    # Formatting from array test
    it 'can convert an array into json string' do
      formatter = VPCFRJSONFormatter.new
      result = formatter.format(VPCFRTestData.arrayData)
      expect(result).to eq(VPCFRTestData.formatterJSONArrayResult)
    end

    # Formatting from hash test
    it 'can convert a hash into json string' do
      formatter = VPCFRJSONFormatter.new
      result = formatter.format(VPCFRTestData.hashData)
      expect(result).to eq(VPCFRTestData.formatterJSONHashResult)
    end
  end
end
