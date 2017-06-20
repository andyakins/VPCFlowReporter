require_relative '../../app/vpcfrParser'
require_relative '../vpcfrTestData'

module VPCFR
RSpec.describe 'A correct parser' do

  it 'can parse data into an aggregated map' do
    parser = VPCFRParser.new('srcaddr','action','REJECT',false)
    result = parser.parse(VPCFRTestData.arrayData)
    expect(result.size).to eq(2)
    expect(result['172.31.9.69']).to eq(1)
    expect(result['172.31.16.139']).to eq(1)
    expect(result['172.31.9.49']).to eq(0)
  end

  it 'can parse data into an array of maps' do
    parser = VPCFRParser.new('none','action','REJECT',false)
    result = parser.parse(VPCFRTestData.arrayData)
    expect(result.size).to eq(2)
    expect(result[0]['srcaddr']).to eq('172.31.9.69')
    expect(result[1]['srcaddr']).to eq('172.31.16.139')
  end

  it 'can parse data into an aggregated map based on a regexp' do
    parser = VPCFRParser.new('action','srcaddr','172\.31\.9\.*',true)
    result = parser.parse(VPCFRTestData.arrayData)
    expect(result.size).to eq(2)
    expect(result['ACCEPT']).to eq(1)
    expect(result['REJECT']).to eq(1)
  end

  it 'can parse data into an array of maps based on a regex' do
    parser = VPCFRParser.new('none','srcaddr','172\.31\.9\.*',true)
    result = parser.parse(VPCFRTestData.arrayData)
    expect(result.size).to eq(2)
    expect(result[0]['srcaddr']).to eq('172.31.9.69')
    expect(result[1]['srcaddr']).to eq('172.31.9.49')
  end

end
end
