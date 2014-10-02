describe MazeBTrace do
	before do
		@width = rand(10) + 15
		@height = rand(10) + 15
		@maze = MazeBTrace.new(@width, @height)
	end

	it '#generate' do
		expect { @maze.generate }.not_to raise_error
	end
end
