require_relative '../../app/vpcfrJSONFormatter'
require_relative '../vpcfrTestData'

module VPCFR
RSpec.describe 'A correct json formatter' do

  it 'can convert an array into json string' do
    formatter = VPCFRJSONFormatter.new
    result = formatter.format(VPCFRTestData.arrayData)
    expect(result).to eq(VPCFRTestData.formatterJSONArrayResult)
  end

  it 'can convert a hash into json string' do
    formatter = VPCFRJSONFormatter.new
    result = formatter.format(VPCFRTestData.hashData)
    expect(result).to eq(VPCFRTestData.formatterJSONHashResult)
  end

end
end
