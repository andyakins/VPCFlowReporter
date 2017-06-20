require_relative '../../app/vpcfrDelimitedFormatter'
require_relative '../vpcfrTestData'

module VPCFR

  # VPCFRDelimitedFormatter unit tests
  RSpec.describe 'A correct delimited formatter' do

    # Straight CSV generation from an array test
    it 'can convert an array into csv string' do
      formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
      result = formatter.format(VPCFRTestData.arrayData)
      expect(formatter.delimiter).to eq(',')
      expect(result).to eq(VPCFRTestData.formatterCSVArrayResult)
    end

    # Testing CSV generation with a semicolon separator, from an array.
    it 'can convert an array into csv string with custom delimiter' do
      formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
      formatter.delimiter = ';'
      result = formatter.format(VPCFRTestData.arrayData)
      expect(result).to eq(VPCFRTestData.formatterCSVCustomArrayResult)
      expect(formatter.delimiter).to eq(';')
    end

    # Straight CSV generation from a hash test.
    it 'can convert a hash into csv string' do
      formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
      result = formatter.format(VPCFRTestData.hashData)
      expect(formatter.delimiter).to eq(',')
      expect(result).to eq(VPCFRTestData.formatterCSVHashResult)
    end

    # Testing CSV generation with a semicolon separator, from a hash.
    it 'can convert a hash into csv string with a custom delimiter' do
      formatter = VPCFRDelimitedFormatter.new(VPCFRTestData.columnNames)
      formatter.delimiter = ';'
      result = formatter.format(VPCFRTestData.hashData)
      expect(formatter.delimiter).to eq(';')
      expect(result).to eq(VPCFRTestData.formatterCSVCustomHashResult)
    end
  end
end
