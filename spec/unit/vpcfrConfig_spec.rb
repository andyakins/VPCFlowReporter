require_relative '../../app/vpcfrConfig'
require_relative '../vpcfrTestData'

module VPCFR
RSpec.describe 'A correct configuration' do
  before { VPCFRTestData.setDefaultEnvironment }

  it 'has the correct default settings' do
    args = ['source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ',', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can change its aggregate column to a custom value' do
    args = ['-a','logstatus','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'logstatus',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ',', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can change its check column to a custom value' do
    args = ['-c','logstatus','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'logstatus', pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ',', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can have its destination type set to file' do
    args = ['-d','file','source','destination']
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion, checkCol: 'action', pattern: 'REJECT',
      version: '1.0', source: 'source', destination: 'destination',
      delimiter: ',', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRFileWriter)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can have its formatter set to delimited' do
    args = ['-f','delimited','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ',', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can have its formatter set to delimited with a custom delimiter' do
    args = ['-f','delimited','--delimiter',';','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ';', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can have its formatter set to delimited with a space delimiter' do
    args = ['-f','delimited','--space','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ' ', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can have its aws parameters set to custom values' do
    args = ['-i','awskey','-k','awssecret','-r','awsregion','source',
      VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: 'awskey', awsSecretAccessKey: 'awssecret',
      awsRegion: 'awsregion', checkCol: 'action',
      pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ',', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can check for a custom pattern' do
    args = ['-p','ACCEPT','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'srcaddr',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'action', pattern: 'ACCEPT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ',', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'can run in raw mode (no aggregate, space delimited)' do
    args = ['--raw','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config).to have_attributes(aggregateCol: 'none',
      awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
      awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
      awsRegion: VPCFRTestData.awsRegion,
      checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
      destination: VPCFRTestData.awsS3URL, delimiter: ' ', message: '')
    expect(config.isGood?).to eq(true)
    expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
    expect(config.reader).to be_instance_of(VPCFRFileReader)
    expect(config.writer).to be_instance_of(VPCFRS3Writer)
    expect(config.parser).to be_instance_of(VPCFRParser)
  end

  it 'will create the help banner message' do
    args = ['-h','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config.message).not_to eq('')
  end

  it 'will display the version number message' do
    args = ['-v','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config.message).to eq("VPC Flow Reporter version #{config.version}")
  end

  it 'will reject improper column names' do
    args = ['-a','badname','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config.isGood?).to eq(false)
    expect(config.message).not_to eq('')
  end

  it 'will reject improper options' do
    args = ['-x','source',VPCFRTestData.awsS3URL]
    config = VPCFRConfig.new(args)
    expect(config.isGood?).to eq(false)
    expect(config.message).not_to eq('')
  end
end
end
