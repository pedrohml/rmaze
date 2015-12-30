class MazeCell
	attr_reader :maze, :coords

	def initialize(*params)
		params = params.clone
		@maze = params.shift
		@coords = params.map { |c| c.to_i }
		@hash = "#{@maze.hash}#{ @coords.reduce(""){ |accum, c| "#{accum}#{c}" }.to_i }".to_i
	end

	def value
		@maze.get_value *@coords
	end

	def backward(dimension_index)
		coords = @coords.clone
		coords[dimension_index] -= 1
		params = coords.clone
		params.unshift @maze
		MazeCell.new *params if @coords[dimension_index] > 0
	end

	def forward(dimension_index)
		coords = @coords.clone
		coords[dimension_index] += 1
		params = coords.clone
		params.unshift @maze
		MazeCell.new *params if @coords[dimension_index] < (@maze.dimensions[dimension_index] - 1)
	end

	def has_wall_forward(dimension_index)
		indices = @maze.coords_to_indices *@coords
		indices[dimension_index] += 1
		@coords[dimension_index] >= @maze.dimensions[dimension_index] - 1 or @maze.get_raw_value(*indices) == 1
	end

	def has_wall_backward(dimension_index)
		indices = @maze.coords_to_indices *@coords
		indices[dimension_index] -= 1
		@coords[dimension_index] <= 0 or @maze.get_raw_value(*indices) == 1
	end

	def connected?
		has_wall = true
		(0...@maze.dimensions.length).each do |d|
			has_wall = has_wall && has_wall_forward(d) && has_wall_backward(d)
			break unless has_wall
		end
		not has_wall
	end

	def neighbours
		(0...@maze.dimensions.length).map { |d| [forward(d), backward(d)] }.flatten.compact
	end

	def connected_neighbours
		neighbours = []
		(0...@maze.dimensions.length).each do |d|
			neighbours << forward(d) unless has_wall_forward(d)
			neighbours << backward(d) unless has_wall_backward(d)
		end
		neighbours
	end
	
	def hash
		@hash
	end

	def eql?(object)
		if (object.class == self.class)
			eq = (@maze == object.maze)
			@coords.each_with_index do |c, c_idx|
				eq = eq && c == object[c_idx]
			end
			eq
		elsif
			super(object)
		end
	end

	def [](dimension_index)
		@coords[dimension_index]
	end

	def ==(object)
		self.eql? object
	end

	def !=(object)
		not self.eql? object
	end

	def inspect
		unless @inspect
			c_index = 0
			coord_list = @coords.map { |c| "@c#{c_index+=1}=#{c}" }
			@inspect = "#<#{self.class}: @maze=#{@maze.inspect}, #{coord_list.join(', ')}>"
		end
		@inspect
	end
end
