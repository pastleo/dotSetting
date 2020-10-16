#!/usr/bin/env ruby

my_ips = `ip addr | grep -oE 'inet [.[:digit:]]+' | grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | grep -v '127.0.0.1'`.split("\n")
android_ips = `adb shell 'ip addr' | grep -oE 'inet [.[:digit:]]+' | grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | grep -v '127.0.0.1'`.split("\n")

puts "my_ips: #{my_ips}"
puts "android_ips: #{android_ips}"
if my_ips.count == 0 || android_ips.count == 0
  puts "ip not detected, there should be one and only device connected or no permission:"
  puts `adb devices -l`
  exit 1
end

def cidr(ip_a, ip_b)
  (
    ip_a.split('.').zip(ip_b.split('.')).find_index do |a, b|
      a.to_i != b.to_i
    end || 4
  ) * 8
end

my_ip, android_ip = my_ips.flat_map do |my_ip|
  android_ips.map do |android_ip|
    [my_ip, android_ip]
  end
end.sort do |com_a, com_b|
  cidr(*com_b) <=> cidr(*com_a)
end.first

puts "chosen my_ip: #{my_ip}"
puts "chosen android_ip: #{android_ip}"

port = rand(5555..25565)

puts "chosen port: #{port}"

puts " => adb tcpip #{port}"
puts `adb tcpip #{port}`

puts "wait 3 secs..."
sleep 3

puts " => adb connect #{android_ip}:#{port}"
puts `adb connect #{android_ip}:#{port}`
