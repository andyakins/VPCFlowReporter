require_relative '../../app/vpcfrConfig'

def setDefaultEnvironment
  ENV['AWS_ACCESS_KEY_ID'] = 'defaultAwsAccessKeyID'
  ENV['AWS_SECRET_ACCESS_KEY'] = 'defaultAwsSecretAccessKey'
  ENV['AWS_REGION'] = 'defaultAwsRegion'
  ['source','destination']
end

module VPCFR
  RSpec.describe 'A correct configuration' do
    it 'has the correct default settings' do
      args = setDefaultEnvironment
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can have its destination type set to file' do
      setDefaultEnvironment
      args = ['-d','file','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion', checkCol: 'action', pattern: 'REJECT',
        version: '1.0', source: 'source', destination: 'destination')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRFileWriter)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can have its aws parameters set type set to custom values' do
      setDefaultEnvironment
      args = ['-i','awskey','-k','awssecret','-r','awsregion','source',
        'destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'awskey', awsSecretAccessKey: 'awssecret',
        awsRegion: 'awsregion', checkCol: 'action',
        pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end
  end
end
