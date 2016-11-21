#!/usr/bin/env ruby
require "json"

def mem(pid)
	`ps p #{pid} -o rss`.split.last.to_i; 
end

t = Time.now
pid = Process.spawn(*ARGV.to_a)
mm = 0

Thread.new do
  mm = mem(pid)
  while true
    sleep 0.3
    m = mem(pid)
    mm = m if m > mm
  end
end

Process.waitall
time = Time.now - t
memory =  mm / 1024.0

json = {time: time, memory: memory}.to_json

result_path = File.join "../results", "results.json"
File.open(result_path, "a") {|f| f.puts json}

STDERR.puts "== %.2fs, %.1fMb ==" % [time, memory]