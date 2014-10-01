require 'maze/maze_btrace'

describe MazeBTrace do
	before do
		@width = rand(10) + 15
		@height = rand(10) + 15
		@maze = MazeBTrace.new(@width, @height)
	end
	it '#generate' do
		@maze.generate
		expect(@maze.value(0, 0)).to eq(1)
	end
end
