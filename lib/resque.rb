#!/usr/bin/env ruby1.8

class Workaround
  def initialize target_pid
    @target_pid = target_pid

    first_child
  end

  def first_child
    pid = fork do
      Process.setsid

      rio, wio = IO.pipe

      # Keep rio open
      until second_child rio, wio
        print "\e[A"
      end
    end

    Process.wait pid
  end

  def second_child parent_rio, parent_wio
    rio, wio = IO.pipe

    pid = fork do
      rio.close
      parent_wio.close

      puts "%20.20s" % Process.pid

      if Process.pid == @target_pid
        wio << 'a'
        wio.close

        parent_rio.read
      end
    end
    wio.close

    begin
      if rio.read == 'a'
        true
      else
        Process.wait pid
        false
      end
    ensure
      rio.close
    end
  end
end

if $0 == __FILE__
  pid = ARGV.shift
  raise "USAGE: #{$0} pid" if pid.nil?
  Workaround.new Integer pid
end