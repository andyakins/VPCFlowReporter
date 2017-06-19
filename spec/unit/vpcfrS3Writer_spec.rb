require 'fileutils'
require_relative '../../app/vpcfrS3Writer'
require_relative '../vpcfrTestData'


module VPCFR

  RSpec.describe 'A correct s3 writer' do

  it 'can parse the destination to bucket and key elements' do
    writer = VPCFRS3Writer.new(VPCFRTestData.awsAccessKeyID,
      VPCFRTestData.awsSecretAccessKey, VPCFRTestData.awsRegion)
    writer.destination = VPCFRTestData.awsS3URL
    expect(writer.bucket).to eq(VPCFRTestData.awsS3Bucket)
    expect(writer.key).to eq(VPCFRTestData.awsS3Key)
  end

end
end
