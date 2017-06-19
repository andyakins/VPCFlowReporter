require 'aws-sdk'
require_relative '../../app/vpcfrRunner.rb'
require_relative '../vpcfrTestData'

module VPCFR
  RSpec.describe 'A correct configuration' do
    source = 'data/sample.dat'
    destination = 'data/acceptance.test'

    it 'can run and produce an output file' do
      if File.exist?(destination)
        FileUtils.rm(destination)
      end
      runner = VPCFRRunner.new
      runner.run(['-d','file',source,destination])
      expect(FileUtils.compare_file(destination,'data/acceptNorm.dat')).to eq(true)
    end

    it 'can run and write to S3' do
      s3 = Aws::S3::Resource.new(region: VPCFRTestData.awsRegion,
        credentials: Aws::Credentials.new(VPCFRTestData.awsAccessKeyID,
          VPCFRTestData.awsSecretAccessKey))
      obj = s3.bucket(VPCFRTestData.awsS3Bucket).object(VPCFRTestData.awsS3Key)
      if obj.exists?
        s3.client.delete_object({bucket: VPCFRTestData.awsS3Bucket,
          key: VPCFRTestData.awsS3Key})
      end
      runner = VPCFRRunner.new
      runner.run([source,VPCFRTestData.awsS3URI])
      obj = s3.bucket(VPCFRTestData.awsS3Bucket).object(VPCFRTestData.awsS3Key)
      expect(obj.exists?).to eq(true)
    end

    it 'can run in raw mode and produce an output file' do
      if File.exist?(destination)
        FileUtils.rm(destination)
      end
      runner = VPCFRRunner.new
      runner.run(['--raw','-d','file',source,destination])
      expect(FileUtils.compare_file(destination,'data/acceptRaw.dat')).to eq(true)
    end
  end
end
