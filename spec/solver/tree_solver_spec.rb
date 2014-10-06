describe TreeSolver do
	before do
		@maze = MazeBTrace.new(4, 4)
		@maze.generate
		@tree_solver = TreeSolver.new(@maze)
	end

	it '#paths' do
		paths = @tree_solver.paths(0, 0)
		expect(paths.name).to eq('0,0')
		expect(paths.size).to eq(16)
	end
end
