describe MazeCell do
	before do
		@width = 4
		@height = 4
		@maze = MazeBTrace.new(@width, @height)
		@maze_zero = Maze.new(@width, @height)
	end

	it '#initialize' do
		maze_cell = MazeCell.new(@maze, 1, 0)
		expect(maze_cell.maze).to eq(@maze)
		expect(maze_cell.x).to eq(1)
		expect(maze_cell.y).to eq(0)
	end

	it 'gets directions' do
		maze_cell = @maze.cell(0, 0)
		expect(maze_cell.left).to be_nil
		expect(maze_cell.up).to be_nil
		expect(maze_cell.right).to eq(@maze.cell(1, 0))
		expect(maze_cell.down).to eq(@maze.cell(0, 1))
	end

	it 'checks wall' do
		maze_cell = @maze.cell(0, 0)
		expect(maze_cell).to have_wall_left
		expect(maze_cell).to have_wall_up
		expect(maze_cell).to have_wall_right
		expect(maze_cell).to have_wall_down
		maze_zero_cell = @maze_zero.cell(1, 1)
		expect(maze_zero_cell).not_to have_wall_left
		expect(maze_zero_cell).not_to have_wall_up
		expect(maze_zero_cell).not_to have_wall_right
		expect(maze_zero_cell).not_to have_wall_down
	end

	it '#connected?' do
		expect(@maze.cell(0, 0)).not_to be_connected
		expect(@maze_zero.cell(1, 0)).to be_connected
	end

	it '#connected_neighbours' do
		expect(@maze.cell(0, 0).connected_neighbours).to be_empty
		expect(@maze_zero.cell(1, 1).connected_neighbours.size).to eq(4)
	end

	it '#neighbours' do
		maze_cell = @maze.cell(0, 0)
		neighbours = maze_cell.neighbours
		expect(neighbours.size).to eq(2)
		expect(neighbours).to include(@maze.cell(1, 0))
		expect(neighbours).to include(@maze.cell(0, 1))
		expect(neighbours).not_to include(@maze.cell(0, 0))
	end

	it '#hash' do
		allow_any_instance_of(MazeCell).to receive(:eql?).and_return(true) # remove elements only based on hash
		cells = [@maze.cell(0, 0), @maze.cell(1, 0), @maze.cell(0, 1)]
		cells -= [@maze.cell(0, 0)]
		expect(cells).to contain_exactly(@maze.cell(1, 0), @maze.cell(0, 1))
	end

	it '#eql?' do
		maze_cell = @maze.cell(0, 0)
		expect(maze_cell).to eql(maze_cell)
		expect(maze_cell).to eql(@maze.cell(0, 0))
		expect(maze_cell).not_to eql(@maze.cell(1, 0))
		expect(maze_cell).not_to eql(nil)
	end

	it '#==' do
		maze_cell = @maze.cell(0, 0)
		expect(maze_cell).to eq(maze_cell)
		expect(maze_cell).to eq(@maze.cell(0, 0))
		expect(maze_cell).not_to eq(@maze.cell(1, 0))
		expect(maze_cell).not_to eq(nil)
	end

	it '#!=' do
		maze_cell = @maze.cell(0, 0)
		expect(maze_cell != @maze.cell(1, 0)).to be_truthy
		expect(maze_cell != nil).to be_truthy
	end

	it '#debug' do
		allow($stdout).to receive(:puts).exactly(3).times
		maze_cell = @maze.cell(0, 0)
		maze_cell.debug
	end

	it '#inspect' do
		maze_cell = @maze.cell(1, 0)
		expect(maze_cell.inspect).to eq("#<MazeCell: @maze=#{@maze.inspect}, @x=#{1}, @y=#{0}>")
	end
end
