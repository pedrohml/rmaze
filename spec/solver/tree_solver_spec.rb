describe TreeSolver do
    it '#paths 2d' do
        maze = Maze.new 4, 4
        backtrace = Backtrace.new maze
        backtrace.generate
        tree_solver = TreeSolver.new maze
        paths = tree_solver.paths 0, 0
        expect(paths.name).to eq('0,0')
        expect(paths.size).to eq(16)
    end

    it '#paths Nd' do
        dimensions = ([nil]*(rand(4)+2)).map { |_| 1 + rand(4)  }
        maze = Maze.new *dimensions
        backtrace = Backtrace.new maze
        backtrace.generate
        tree_solver = TreeSolver.new maze
        start_coords = [0]*dimensions.length
        paths = tree_solver.paths *start_coords
        expect(paths.name).to eq(start_coords.map(&:to_s).join(','))
        expect(paths.size).to be > 0
    end
end
