require_relative '../../app/vpcfrConfig'
require_relative '../vpcfrTestData'

module VPCFR

  # VPCFRConfig unit tests
  RSpec.describe 'A correct configuration' do
    before { VPCFRTestData.setDefaultEnvironment }

    # Default construction test
    it 'has the correct default settings' do
      args = ['source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -a test
    it 'can change its aggregate column to a custom value' do
      args = ['-a','logstatus','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'logstatus',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --aggregate test
    it 'can change its aggregate column to a custom value (long option)' do
      args = ['--aggregate','logstatus','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'logstatus',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -c test
    it 'can change its check column to a custom value' do
      args = ['-c','logstatus','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'logstatus', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --check test
    it 'can change its check column to a custom value (long option)' do
      args = ['--check','logstatus','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'logstatus', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -d test for files
    it 'can have its destination type set to file' do
      args = ['-d','file','source','destination']
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion, checkCol: 'action', pattern: 'REJECT',
        version: '1.0', source: 'source', destination: 'destination',
        delimiter: ',', message: '', regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRFileWriter)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --destination test for files
    it 'can have its destination type set to file (long option)' do
      args = ['--destination','file','source','destination']
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion, checkCol: 'action', pattern: 'REJECT',
        version: '1.0', source: 'source', destination: 'destination',
        delimiter: ',', message: '', regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRFileWriter)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -d test for standard output
    it 'can have its destination type set to standard out' do
      args = ['-d','stdout','source']
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion, checkCol: 'action', pattern: 'REJECT',
        version: '1.0', source: 'source', destination: '',
        delimiter: ',', message: '', regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRSTDOUTWriter)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -f test for CSV
    it 'can have its formatter set to delimited' do
      args = ['-f','delimited','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --format test for CSV
    it 'can have its formatter set to delimited (long option)' do
      args = ['--format','delimited','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -f test for CSV with a semicolon (;) delimiter
    it 'can have its formatter set to delimited with a custom delimiter' do
      args = ['-f','delimited','--delimiter',';','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ';', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -f test for CSV with a space delimiter
    it 'can have its formatter set to delimited with a space delimiter' do
      args = ['--format','delimited','--space','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ' ', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # i-, -k, -r test
    it 'can have its aws parameters set to custom values' do
      args = ['-i','awskey','-k','awssecret','-r','awsregion','source',
        VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'awskey', awsSecretAccessKey: 'awssecret',
        awsRegion: 'awsregion', checkCol: 'action',
        pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --awsaccesskeyid, --awssecretaccesskey, --awsregion test
    it 'can have its aws parameters set to custom values (long options)' do
      args = ['--awsaccesskeyid','awskey','--awssecretaccesskey','awssecret',
        '--awsregion','awsregion','source', VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'awskey', awsSecretAccessKey: 'awssecret',
        awsRegion: 'awsregion', checkCol: 'action',
        pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -p test
    it 'can check for a custom pattern' do
      args = ['-p','ACCEPT','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'ACCEPT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --pattern test
    it 'can check for a custom pattern (long option)' do
      args = ['--pattern','ACCEPT','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'ACCEPT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -x test
    it 'can check for a custom pattern using regular expressions' do
      args = ['-p','ACCEPT','-x','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'ACCEPT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: true)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --regex test
    it 'can check for a custom pattern using regular expressions (long option)' do
      args = ['-p','ACCEPT','--regex','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'ACCEPT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ',', message: '',
        regex: true)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # --raw test
    it 'can run in raw mode (no aggregate, space delimited)' do
      args = ['--raw','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config).to have_attributes(aggregateCol: 'none',
        awsAccessKeyID: VPCFRTestData.awsAccessKeyID,
        awsSecretAccessKey: VPCFRTestData.awsSecretAccessKey,
        awsRegion: VPCFRTestData.awsRegion,
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: VPCFRTestData.awsS3URI, delimiter: ' ', message: '',
        regex: false)
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    # -h test
    it 'will create the help banner message' do
      args = ['-h','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config.message).not_to eq('')
    end

    # --help test
    it 'will create the help banner message (long option)' do
      args = ['--help','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config.message).not_to eq('')
    end

    # -v test
    it 'will display the version number message' do
      args = ['-v','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config.message).to eq("VPC Flow Reporter version #{config.version}")
    end

    # --version test
    it 'will display the version number message (long option)' do
      args = ['--version','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config.message).to eq("VPC Flow Reporter version #{config.version}")
    end

    # bad column names test
    it 'will reject improper column names' do
      args = ['-a','badname','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config.isGood?).to eq(false)
      expect(config.message).not_to eq('')
    end

    # bad option test
    it 'will reject improper options' do
      args = ['--badoption','source',VPCFRTestData.awsS3URI]
      config = VPCFRConfig.new(args)
      expect(config.isGood?).to eq(false)
      expect(config.message).not_to eq('')
    end
  end
end
