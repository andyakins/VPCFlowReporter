require_relative '../../app/vpcfrDelimitedFormatter'
require_relative '../vpcfrTestData'

module VPCFR
RSpec.describe 'A correct delimited formatter' do
  it 'can convert an array into csv string' do
    formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
    result = formatter.format(VPCFRTestData.arrayData)
    expect(formatter.delimiter).to eq(',')
    expect(result).to eq(VPCFRTestData.formatterCSVArrayResult)
  end

  it 'can convert an array into csv string with custom delimiter' do
    formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
    formatter.delimiter = ';'

    result = formatter.format(VPCFRTestData.arrayData)
    expect(result).to eq(VPCFRTestData.formatterCSVCustomArrayResult)
    expect(formatter.delimiter).to eq(';')
  end

  it 'can convert a hash into csv string' do
    formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
    result = formatter.format(VPCFRTestData.hashData)
    expect(formatter.delimiter).to eq(',')
    expect(result).to eq(VPCFRTestData.formatterCSVHashResult)
  end

  it 'can convert a hash into csv string with a custom delimiter' do
    formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
    formatter.delimiter = ';'
    result = formatter.format(VPCFRTestData.hashData)
    expect(formatter.delimiter).to eq(';')
    expect(result).to eq(VPCFRTestData.formatterCSVCustomHashResult)
  end
end
end
