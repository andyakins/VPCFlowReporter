class VPCFRTestData

  # NOTE!
  # In order for the integration and acceptance tests to work,
  # the following values must point to a valid AWS account/region/bucket
  @@awsAccessKeyID = ''
  @@awsSecretAccessKey = ''
  @@awsRegion = ''
  @@awsS3URI = 's3://vpcfr/vpcfr.dat'
  @@awsS3Bucket = 'vpcfr' # value that should be parsed for bucket from URL
  @@awsS3Key = 'vpcfr.dat' # value that should be parsed for key from URL


  # Generic Test data
  # Placed in this file for reuse across tests

  @@columnNames = ['version','accountid','interfaceid','srcaddr','dstaddr',
    'srcport','dstport','protocol','packets','bytes','start','end',
    'action','logstatus']

  @@arrayData = [
    {
      "version"=>"2", "accountid"=>"123456789010",
      "interfaceid"=>"eni-abc123de", "srcaddr"=>"172.31.9.69",
      "dstaddr"=>"172.31.9.12", "srcport"=>"49761",
      "dstport"=>"3389", "protocol"=>"6", "packets"=>"20",
      "bytes"=>"4249", "start"=>"1418530010",
      "end"=>"1418530070", "action"=>"REJECT", "logstatus"=>"OK"
    },
    {
      "version"=>"2", "accountid"=>"123456789010",
      "interfaceid"=>"eni-1235b8ca", "srcaddr"=>"172.31.16.139",
      "dstaddr"=>"203.0.113.12", "srcport"=>"0", "dstport"=>"0",
      "protocol"=>"1", "packets"=>"4", "bytes"=>"336",
      "start"=>"1432917094", "end"=>"1432917142",
      "action"=>"REJECT", "logstatus"=>"OK"
    },
    {
      "version"=>"2", "accountid"=>"123456789010",
      "interfaceid"=>"eni-abc123de", "srcaddr"=>"172.31.9.49",
      "dstaddr"=>"172.31.9.22", "srcport"=>"49761",
      "dstport"=>"3389", "protocol"=>"6", "packets"=>"20",
      "bytes"=>"4249", "start"=>"1418530010", "end"=>"1418530070",
      "action"=>"ACCEPT", "logstatus"=>"OK"
    }
  ]

  @@hashData = {"172.16.8.1"=>2,"172.16.8.2"=>3,"172.16.8.3"=>4}

  @@formatterCSVArrayResult = <<~HEREDOC
    2,123456789010,eni-abc123de,172.31.9.69,172.31.9.12,49761,3389,6,20,4249,1418530010,1418530070,REJECT,OK
    2,123456789010,eni-1235b8ca,172.31.16.139,203.0.113.12,0,0,1,4,336,1432917094,1432917142,REJECT,OK
    2,123456789010,eni-abc123de,172.31.9.49,172.31.9.22,49761,3389,6,20,4249,1418530010,1418530070,ACCEPT,OK
  HEREDOC

  @@formatterCSVCustomArrayResult = <<~HEREDOC
    2;123456789010;eni-abc123de;172.31.9.69;172.31.9.12;49761;3389;6;20;4249;1418530010;1418530070;REJECT;OK
    2;123456789010;eni-1235b8ca;172.31.16.139;203.0.113.12;0;0;1;4;336;1432917094;1432917142;REJECT;OK
    2;123456789010;eni-abc123de;172.31.9.49;172.31.9.22;49761;3389;6;20;4249;1418530010;1418530070;ACCEPT;OK
  HEREDOC

  @@formatterCSVHashResult = <<~HEREDOC
    172.16.8.1,2
    172.16.8.2,3
    172.16.8.3,4
  HEREDOC

  @@formatterCSVCustomHashResult = <<~HEREDOC
    172.16.8.1;2
    172.16.8.2;3
    172.16.8.3;4
  HEREDOC

  @@formatterJSONArrayResult = <<~HEREDOC
  [
    {
      "version": "2",
      "accountid": "123456789010",
      "interfaceid": "eni-abc123de",
      "srcaddr": "172.31.9.69",
      "dstaddr": "172.31.9.12",
      "srcport": "49761",
      "dstport": "3389",
      "protocol": "6",
      "packets": "20",
      "bytes": "4249",
      "start": "1418530010",
      "end": "1418530070",
      "action": "REJECT",
      "logstatus": "OK"
    },
    {
      "version": "2",
      "accountid": "123456789010",
      "interfaceid": "eni-1235b8ca",
      "srcaddr": "172.31.16.139",
      "dstaddr": "203.0.113.12",
      "srcport": "0",
      "dstport": "0",
      "protocol": "1",
      "packets": "4",
      "bytes": "336",
      "start": "1432917094",
      "end": "1432917142",
      "action": "REJECT",
      "logstatus": "OK"
    },
    {
      "version": "2",
      "accountid": "123456789010",
      "interfaceid": "eni-abc123de",
      "srcaddr": "172.31.9.49",
      "dstaddr": "172.31.9.22",
      "srcport": "49761",
      "dstport": "3389",
      "protocol": "6",
      "packets": "20",
      "bytes": "4249",
      "start": "1418530010",
      "end": "1418530070",
      "action": "ACCEPT",
      "logstatus": "OK"
    }
  ]
  HEREDOC

  @@formatterJSONHashResult = <<~HEREDOC
  {
    "172.16.8.1": 2,
    "172.16.8.2": 3,
    "172.16.8.3": 4
  }
  HEREDOC

  def self.columnNames
    @@columnNames
  end

  def self.arrayData
    @@arrayData
  end

  def self.hashData
    @@hashData
  end

  def self.formatterCSVArrayResult
    @@formatterCSVArrayResult
  end

  def self.formatterCSVCustomArrayResult
    @@formatterCSVCustomArrayResult
  end

  def self.formatterCSVHashResult
    @@formatterCSVHashResult
  end

  def self.formatterCSVCustomHashResult
    @@formatterCSVCustomHashResult
  end

  def self.formatterJSONArrayResult
    @@formatterJSONArrayResult.rstrip
  end

  def self.formatterJSONHashResult
    @@formatterJSONHashResult.rstrip
  end

  def self.awsAccessKeyID
    @@awsAccessKeyID
  end

  def self.awsSecretAccessKey
    @@awsSecretAccessKey
  end

  def self.awsRegion
    @@awsRegion
  end

  def self.awsS3URI
    @@awsS3URI
  end

  def self.awsS3Bucket
    @@awsS3Bucket
  end

  def self.awsS3Key
    @@awsS3Key
  end

  def self.setDefaultEnvironment
    ENV['AWS_ACCESS_KEY_ID'] = @@awsAccessKeyID
    ENV['AWS_SECRET_ACCESS_KEY'] = @@awsSecretAccessKey
    ENV['AWS_REGION'] = @@awsRegion
  end

end
