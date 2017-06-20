require 'aws-sdk'
require_relative '../../app/vpcfrS3Writer'
require_relative '../vpcfrTestData'

module VPCFR

  #Tests connecting to S3 using the VPCFRS3Writer.
  RSpec.describe 'Proper S3 integration' do

    #Deletes a record if its already there, then writes it and tests
    #for existance.
    it 'will be able to write data to S3' do
      writer = VPCFRS3Writer.new(VPCFRTestData.awsAccessKeyID,
        VPCFRTestData.awsSecretAccessKey, VPCFRTestData.awsRegion)
      writer.destination = VPCFRTestData.awsS3URI

      s3 = Aws::S3::Resource.new(region: VPCFRTestData.awsRegion,
        credentials: Aws::Credentials.new(VPCFRTestData.awsAccessKeyID,
          VPCFRTestData.awsSecretAccessKey))
        obj = s3.bucket(VPCFRTestData.awsS3Bucket).object(VPCFRTestData.awsS3Key)
      if obj.exists?
        s3.client.delete_object({bucket: VPCFRTestData.awsS3Bucket,
          key: VPCFRTestData.awsS3Key})
      end
      writer.write("This is test data")
      expect(writer.bucket).to eq(VPCFRTestData.awsS3Bucket)
      expect(writer.key).to eq(VPCFRTestData.awsS3Key)
      obj = s3.bucket(VPCFRTestData.awsS3Bucket).object(VPCFRTestData.awsS3Key)
      expect(obj.exists?).to eq(true)
    end
  end
end
