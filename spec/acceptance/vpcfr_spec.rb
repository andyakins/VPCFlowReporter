require_relative '../../app/vpcfrRunner.rb'

module VPCFR
  RSpec.describe 'A correct configuration' do
    source = 'data/sample.dat'
    destination = 'data/acceptance.test'

    it 'can run  and produce an output file' do
      if File.exist?(destination)
        FileUtils.rm(destination)
      end
      runner = VPCFRRunner.new
      runner.run(['-d','file',source,destination])
      expect(FileUtils.compare_file(destination,'data/acceptNorm.dat')).to eq(true)
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
