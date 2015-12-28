describe Maze do
	it '#initialize 2d' do
		width = rand(10) + 15
		height = rand(10) + 15
		maze = Maze.new(width, height)
		expect(maze.dimensions[0]).to eq(width)
		expect(maze.dimensions[1]).to eq(height)
		expect(maze.matrix.length).to eq(width * 2 + 1) # raw dimensions
		expect(maze.matrix[0].length).to eq(height * 2 + 1) # raw dimensions
	end

	it '#initialize Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		matrix_iter = maze.matrix
		dimensions.each_with_index do |d, d_index|
			expect(maze.dimensions[d_index]).to eq(dimensions[d_index])
			expect(matrix_iter.length).to eq(dimensions[d_index] * 2 + 1) # raw dimensions
			matrix_iter = matrix_iter[0]
		end
	end

	it '#coords_to_indices 2d' do
		maze = Maze.new 4, 8
		x, y = 2, 3
		i, j = maze.coords_to_indices x, y
		expect([i, j]).to eq([5, 7])
	end

	it '#coords_to_indices 3d' do
		maze = Maze.new 4, 8, 7
		x, y, z = 2, 3, 1
		i, j, k = maze.coords_to_indices x, y, z
		expect([i, j, k]).to eq([5, 7, 3])
	end

	it '#coords_to_indices Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		coords = dimensions.map { |d| rand(d) }
		indices = maze.coords_to_indices *coords
		expect(indices).to eq(coords.map { |c| 1 + 2 * c })
	end

	it '#get_raw_value 2d' do
		maze = Maze.new 3, 3
		expect(maze.get_raw_value(0, 0)).to eq(0)
	end

	it '#get_raw_value Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		coords = dimensions.map { |d| rand(d) }
		indices = maze.coords_to_indices *coords
		expect(maze.get_raw_value(*indices)).to eq(0)
	end

	it '#set_raw_value 2d' do
		maze = Maze.new 3, 3
		maze.set_raw_value(0, 0, 10)
		expect(maze.get_raw_value(0, 0)).to eq(10)
		maze.set_raw_value(2, 5, 20)
		expect(maze.get_raw_value(2, 5)).to eq(20)
	end

	it '#set_raw_value Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		coords = dimensions.map { |d| rand(d) }
		value = rand(99) + 1
		indices = maze.coords_to_indices *coords
		params = indices.clone
		params.push value
		maze.set_raw_value *params
		expect(maze.get_raw_value(*indices)).to eq(value)
	end

	it '#set_raw_value_all 2d' do
		maze = Maze.new 3, 3
		maze.set_raw_value_all 10
		coords = maze.dimensions.map { |d| rand(d) }
		indices = maze.coords_to_indices *coords
		expect(maze.get_raw_value(*indices)).to eq(10)
	end

	it '#set_raw_value_all Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		maze.set_raw_value_all 11
		coords = maze.dimensions.map { |d| rand(d) }
		indices = maze.coords_to_indices *coords
		expect(maze.get_raw_value(*indices)).to eq(11)
	end

	it '#get_value 2d' do
		maze = Maze.new 3, 3
		expect(maze.get_value(0, 0)).to eq(0)
	end

	it '#get_value Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		coords = dimensions.map { |d| rand(d) }
		expect(maze.get_value(*coords)).to eq(0)
	end

	it '#set_value 2d' do
		maze = Maze.new 3, 3
		maze.set_value(0, 0, 10)
		expect(maze.get_value(0, 0)).to eq(10)
		maze.set_value(2, 1, 20)
		expect(maze.get_value(2, 1)).to eq(20)
	end

	it '#set_value Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		coords = dimensions.map { |d| rand(d) }
		value = rand(99) + 1
		params = coords.clone
		params.push value
		maze.set_value *params
		expect(maze.get_value(*coords)).to eq(value)
	end

	it '#cell 2d' do
		maze = Maze.new 4, 9
		cell = maze.cell 3, 8
		expect(cell).to be_a_kind_of(MazeCell)
		expect(cell.maze).to eq(maze)
		expect(cell[0]).to eq(3)
		expect(cell[1]).to eq(8)
	end

	it '#cell Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		coords = dimensions.map { |d| rand(d) }
		cell = maze.cell *coords
		expect(cell).to be_a_kind_of(MazeCell)
		expect(cell.maze).to eq(maze)
		coords.each_with_index do |c, c_index|
			expect(cell[c_index]).to eq(c)
		end
	end

	it '#hash 2d' do
		maze = Maze.new 4, 8
		expect(maze.hash).to eq(48)
	end

	it '#hash Nd' do
		dimensions = ([nil]*(rand(10)+3)).map { |_| 1 + rand(4)  }
		maze = Maze.new *dimensions
		expect(maze.hash).to eq(dimensions.reduce(""){ |accum, d| "#{accum}#{d}" }.to_i)
	end

	it '#inspect 2d' do
		maze = Maze.new 3, 6
		expect(maze.inspect).to eq("#<Maze: @d1=3, @d2=6>")
	end

	it '#inspect 3d' do
		maze = Maze.new 1, 5, 7
		expect(maze.inspect).to eq("#<Maze: @d1=1, @d2=5, @d3=7>")
	end
end
