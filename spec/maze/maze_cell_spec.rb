describe MazeCell do
	before do
		@width = 4
		@height = 4
		@maze = Maze.new(@width, @height)
	end

	it '#initialize' do
		coords = [1, 0]
		indices = @maze.coords_to_indices *coords
		params = indices.clone
		params.push rand(99)
		@maze.set_raw_value *params
		maze_cell = MazeCell.new(@maze, 1, 0)
		expect(maze_cell.maze).to eq(@maze)
		expect(maze_cell.coords[0]).to eq(1)
		expect(maze_cell.coords[1]).to eq(0)
		expect(maze_cell.value).to eq(params.last)
	end

	it '#value' do
		coords = [0, 0]
		params = coords.clone
		params.push rand(99)
		@maze.set_value *params
		maze_cell = @maze.cell *coords
		expect(maze_cell.value).to eq(params.last)
	end

	it '#forward' do
		maze_cell = @maze.cell 1, 1
		expect(maze_cell.forward(0)).to eq(@maze.cell(2, 1))
		expect(maze_cell.forward(1)).to eq(@maze.cell(1, 2))
	end

	it '#backward' do
		maze_cell = @maze.cell 1, 1
		expect(maze_cell.backward(0)).to eq(@maze.cell(0, 1))
		expect(maze_cell.backward(1)).to eq(@maze.cell(1, 0))
	end

	it '#has_wall_forward' do
		@maze.set_raw_value_all 1
		coords = [1, 1]
		maze_cell = @maze.cell *coords
		indices = @maze.coords_to_indices *coords
		params = indices.clone
		params[1] += 1
		params.push 0
		@maze.set_raw_value *params
		expect(maze_cell.has_wall_forward(0)).to be_truthy
		expect(maze_cell.has_wall_forward(1)).to be_falsy
	end

	it '#has_wall_backward' do
		@maze.set_raw_value_all 1
		coords = [1, 1]
		maze_cell = @maze.cell *coords
		indices = @maze.coords_to_indices *coords
		params = indices.clone
		params[1] -= 1
		params.push 0
		@maze.set_raw_value *params
		expect(maze_cell.has_wall_backward(0)).to be_truthy
		expect(maze_cell.has_wall_backward(1)).to be_falsy
	end

	it '#has_wall_forward on border' do
		@maze.set_raw_value_all 1
		coords = [@maze.dimensions[0] - 1, @maze.dimensions[1] - 1]
		maze_cell = @maze.cell *coords
		expect(maze_cell.has_wall_forward(0)).to be_truthy
		expect(maze_cell.has_wall_forward(1)).to be_truthy
	end

	it '#has_wall_backward on border' do
		@maze.set_raw_value_all 1
		coords = [0, 0]
		maze_cell = @maze.cell *coords
		expect(maze_cell.has_wall_backward(0)).to be_truthy
		expect(maze_cell.has_wall_backward(1)).to be_truthy
	end

	it '#connected? (0)' do
		coords = [0, 0]
		@maze.set_raw_value_all 0
		maze_cell = @maze.cell *coords
		expect(maze_cell).to be_connected

		@maze.set_raw_value_all 1
		maze_cell = @maze.cell *coords
		expect(maze_cell).not_to be_connected

		indices = @maze.coords_to_indices *coords
		params = indices.clone
		params[1] += 1
		params.push 0
		@maze.set_raw_value *params
		expect(maze_cell).to be_connected
	end

	it '#connected? (1)' do
        maze = Maze.new 3, 3
		maze.set_raw_value_all 1
        maze_cell1 = maze.cell 1, 1
        maze_cell2 = maze.cell 1, 2
        maze.set_value 1, 1, 0
        maze.set_value 1, 2, 0
        maze.connect_cells maze_cell1, maze_cell2

		expect(maze_cell1).to be_connected
	end

	it '#neighbours' do
		maze_cell = @maze.cell(0, 0)
		neighbours = maze_cell.neighbours
		expect(neighbours.size).to eq(2)
		expect(neighbours).to include(@maze.cell(1, 0))
		expect(neighbours).to include(@maze.cell(0, 1))
		expect(neighbours).not_to include(@maze.cell(0, 0))
	end

	it '#connected_neighbours' do
		@maze.set_raw_value_all 1
		expect(@maze.cell(0, 0).connected_neighbours).to be_empty

		@maze.set_raw_value_all 0
		expect(@maze.cell(0, 0).connected_neighbours).to eq([@maze.cell(1, 0), @maze.cell(0, 1)])
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

	it '#inspect' do
		maze_cell = @maze.cell(1, 0)
		expect(maze_cell.inspect).to eq("#<MazeCell: @maze=#{@maze.inspect}, @c1=#{1}, @c2=#{0}>")
	end
end
