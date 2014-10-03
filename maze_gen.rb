#!/usr/bin/env ruby

require './src/init.rb'
require 'optparse'

options = {
	:width => 10,
	:height => 10,
	:algorithm => :backtrace
}
OptionParser.new do |opts|
	opts.banner = "Usage: maze_gen.rb [options]"

	opts.separator ""
	opts.separator "Basic options:"
	opts.on("-w", "--width width", "Specify the maze width (default: #{options[:width]})") do |width|
		options[:width] = width
	end
	opts.on("-h", "--height height", "Specify the maze height (default: #{options[:height]})") do |height|
		options[:height] = height
	end

	opts.separator ""
	opts.separator "Algorithms:"
	opts.on("-b", "--backtrace", "Choose backtrace algorithm (default)") do |bt|
		options[:algorithm] = bt ? :backtrace : nil
	end
end.parse!

maze = nil
case options[:algorithm]
when :backtrace
	maze = MazeBTrace.new(options[:width], options[:height])
else
	$stderr.puts "Error: the algorithm must be set."
	exit(-1)
end

maze.generate
maze.debug