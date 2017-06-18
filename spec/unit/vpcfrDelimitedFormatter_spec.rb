require_relative '../../app/vpcfrDelimitedFormatter'


module VPCFR

  columnNames = ['version','accountid','interfaceid','srcaddr','dstaddr',
      'srcport','dstport','protocol','packets','bytes','start','end',
      'action','logstatus']

  RSpec.describe 'A correct delimited formatter' do
    it 'can convert an array into csv string' do
      formatter = VPCFRDelimitedFormatter.new(columnNames)
      testData = [{"version"=>"2", "accountid"=>"123456789010",
        "interfaceid"=>"eni-abc123de", "srcaddr"=>"172.31.9.69",
        "dstaddr"=>"172.31.9.12", "srcport"=>"49761",
        "dstport"=>"3389", "protocol"=>"6", "packets"=>"20",
        "bytes"=>"4249", "start"=>"1418530010",
        "end"=>"1418530070", "action"=>"REJECT", "logstatus"=>"OK"},
        {"version"=>"2", "accountid"=>"123456789010",
          "interfaceid"=>"eni-1235b8ca", "srcaddr"=>"172.31.16.139",
          "dstaddr"=>"203.0.113.12", "srcport"=>"0", "dstport"=>"0",
          "protocol"=>"1", "packets"=>"4", "bytes"=>"336",
          "start"=>"1432917094", "end"=>"1432917142",
          "action"=>"REJECT", "logstatus"=>"OK"},
          {"version"=>"2", "accountid"=>"123456789010",
            "interfaceid"=>"eni-abc123de", "srcaddr"=>"172.31.9.49",
            "dstaddr"=>"172.31.9.22", "srcport"=>"49761",
            "dstport"=>"3389", "protocol"=>"6", "packets"=>"20",
            "bytes"=>"4249", "start"=>"1418530010", "end"=>"1418530070",
            "action"=>"REJECT", "logstatus"=>"OK"}]
      result = formatter.format(testData)
      expect(formatter.delimiter).to eq(',')
      expect(result).to eq("2,123456789010,eni-abc123de,172.31.9.69,172.31.9.12,49761,3389,6,20,4249,1418530010,1418530070,REJECT,OK\n2,123456789010,eni-1235b8ca,172.31.16.139,203.0.113.12,0,0,1,4,336,1432917094,1432917142,REJECT,OK\n2,123456789010,eni-abc123de,172.31.9.49,172.31.9.22,49761,3389,6,20,4249,1418530010,1418530070,REJECT,OK\n")
    end

    it 'can convert an array into csv string with custom delimiter' do
      formatter = VPCFRDelimitedFormatter.new(columnNames)
      formatter.delimiter = ';'
      testData = [{"version"=>"2", "accountid"=>"123456789010",
        "interfaceid"=>"eni-abc123de", "srcaddr"=>"172.31.9.69",
        "dstaddr"=>"172.31.9.12", "srcport"=>"49761",
        "dstport"=>"3389", "protocol"=>"6", "packets"=>"20",
        "bytes"=>"4249", "start"=>"1418530010",
        "end"=>"1418530070", "action"=>"REJECT", "logstatus"=>"OK"},
        {"version"=>"2", "accountid"=>"123456789010",
          "interfaceid"=>"eni-1235b8ca", "srcaddr"=>"172.31.16.139",
          "dstaddr"=>"203.0.113.12", "srcport"=>"0", "dstport"=>"0",
          "protocol"=>"1", "packets"=>"4", "bytes"=>"336",
          "start"=>"1432917094", "end"=>"1432917142",
          "action"=>"REJECT", "logstatus"=>"OK"},
          {"version"=>"2", "accountid"=>"123456789010",
            "interfaceid"=>"eni-abc123de", "srcaddr"=>"172.31.9.49",
            "dstaddr"=>"172.31.9.22", "srcport"=>"49761",
            "dstport"=>"3389", "protocol"=>"6", "packets"=>"20",
            "bytes"=>"4249", "start"=>"1418530010", "end"=>"1418530070",
            "action"=>"REJECT", "logstatus"=>"OK"}]
      result = formatter.format(testData)
      expect(result).to eq("2;123456789010;eni-abc123de;172.31.9.69;172.31.9.12;49761;3389;6;20;4249;1418530010;1418530070;REJECT;OK\n2;123456789010;eni-1235b8ca;172.31.16.139;203.0.113.12;0;0;1;4;336;1432917094;1432917142;REJECT;OK\n2;123456789010;eni-abc123de;172.31.9.49;172.31.9.22;49761;3389;6;20;4249;1418530010;1418530070;REJECT;OK\n")
      expect(formatter.delimiter).to eq(';')
    end

    it 'can convert a hash into csv string' do
      formatter = VPCFRDelimitedFormatter.new(columnNames)
      testData = {"172.16.8.1"=>2,"172.16.8.2"=>3,"172.16.8.3"=>4}
      result = formatter.format(testData)
      expect(formatter.delimiter).to eq(',')
      expect(result).to eq("172.16.8.1,2\n172.16.8.2,3\n172.16.8.3,4\n")
    end

    it 'can convert a hash into csv string with a custom delimiter' do
      formatter = VPCFRDelimitedFormatter.new(columnNames)
      formatter.delimiter = ';'
      testData = {"172.16.8.1"=>2,"172.16.8.2"=>3,"172.16.8.3"=>4}
      result = formatter.format(testData)
      expect(formatter.delimiter).to eq(';')
      expect(result).to eq("172.16.8.1;2\n172.16.8.2;3\n172.16.8.3;4\n")
    end

  end
end
