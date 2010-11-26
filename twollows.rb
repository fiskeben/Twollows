#!/usr/bin/ruby
# Twollows 0.2
# Author: Ricco Førgaard <ricco@fiskeben.dk>
# Homepage: http://fiskeben.dk
# Released under GPL. You know what it is.
# History:
# Ver. 0.2: Moved from XML API to JSON. Added JSON dependency.
# Ver. 0.1: Initial release.

require 'rubygems'
require 'net/http'
require 'json'

if (ARGV.length != 2)
	puts "Please specify two usernames."
	exit
end

url = "http://twitter.com/friendships/show.json?source_screen_name=#{ARGV[0]}&target_screen_name=#{ARGV[1]}"
response = Net::HTTP.get_response(URI.parse(url)).body
json = JSON.parser.new(response).parse
ship = json['relationship']

source = ship['source']['screen_name']
target = ship['target']['screen_name']
source_follows = ship['source']['following']
target_follows = ship['target']['following']

response = source
response += (source_follows) ? " follows " : " doesn't follow "
response += "#{target}"
response += (source_follows == target_follows) ? " and " : " but "
response += "#{target}"
response += (target_follows) ? " follows back" : " doesn't follow back"
response += "."

puts response
