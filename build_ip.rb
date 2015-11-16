#整理ip段，数据形式：127.0.0.1 127.0.12.11
require 'ipaddr'

class BuildIp
  def initialize(infile, outfile)
    @infile = infile
    @outfile = outfile
  end

  def work
    init_ips
    File.open(@outfile, 'a'){|f|
      @ips.each{|ipd|
        puts ipd
        tmp = ipd.split(' ')
        i1 = IPAddr.new(tmp[0]).to_i
        i2 = IPAddr.new(tmp[1]).to_i
        _s = i1 > i2 ? i2 : i1
        _e = i1 > i2 ? i1 : i2
        (_s.._e).each{|d|
          f.puts(IPAddr.new(d, Socket::AF_INET).to_s)
        }
      }
    }
  end

private
  def init_ips
    @ips = []
    File.open(@infile, 'r'){|f|
      f.each{|t|
        @ips << t
      }
    }
  end
end

BuildIp.new('x.txt', 'ipsc.txt').work

puts 'end'


sss