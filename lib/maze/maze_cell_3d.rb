class MazeCell3D
	attr_reader :maze, :x, :y, :z

	def initialize(maze, x, y, z)
		@maze = maze
		@x, @y, @z = x.to_i, y.to_i, z.to_i
		@x, @y, @z = x % @maze.width, y % @maze.height, z % @maze.depth if @maze.mirrored
		@hash = "#{@maze.hash}#{@x}#{@y}#{@z}".to_i
	end

	def print
		i, j, k = @maze.xyz_to_ijk(@x, @y, @z)
		puts "  #{@maze.value(i - 1, j, k)}  "
		puts "#{@maze.value(i, j - 1, k)} #{@maze.value(i, j, k)} #{@maze.value(i, j + 1, k)}"
		puts "  #{@maze.value(i + 1, j, k)}  "
	end

	def left
		MazeCell3D.new(@maze, @x - 1, @y, @z) if @maze.mirrored || @x > 0
	end

	def up
		MazeCell3D.new(@maze, @x, @y - 1, @z) if @maze.mirrored || @y > 0
	end

	def right
		MazeCell3D.new(@maze, @x + 1, @y, @z) if @maze.mirrored || @x < (@maze.width - 1)
	end

	def down
		MazeCell3D.new(@maze, @x, @y + 1, @z) if @maze.mirrored || @y < (@maze.height - 1)
	end

	def behind
		MazeCell3D.new(@maze, @x, @y, @z + 1) if @maze.mirrored || @z < (@maze.depth - 1)
	end

	def front
		MazeCell3D.new(@maze, @x, @y, @z - 1) if @maze.mirrored || @z > 0
	end

	def has_wall_left?
		i, j, k = @maze.xyz_to_ijk(@x, @y, @z)
		@maze.value(i, j - 1, k) != 0
	end

	def has_wall_up?
		i, j, k = @maze.xyz_to_ijk(@x, @y, @z)
		@maze.value(i - 1, j, k) != 0
	end

	def has_wall_right?
		i, j, k = @maze.xyz_to_ijk(@x, @y, @z)
		@maze.value(i, j + 1, k) != 0
	end

	def has_wall_down?
		i, j, k = @maze.xyz_to_ijk(@x, @y, @z)
		@maze.value(i + 1, j, k) != 0
	end

	def has_wall_front?
		i, j, k = @maze.xyz_to_ijk(@x, @y, @z)
		@maze.value(i, j, k - 1) != 0
	end

	def has_wall_behind?
		i, j, k = @maze.xyz_to_ijk(@x, @y, @z)
		@maze.value(i, j, k + 1) != 0
	end

	def connected?
		!(has_wall_left? && has_wall_up? && has_wall_right? && has_wall_down? && has_wall_behind? && has_wall_front?)
	end

	def neighbours
		[left, up, right, down, behind, front].compact
	end

	def connected_neighbours
		neighbours = []
		neighbours << left unless has_wall_left?
		neighbours << up unless has_wall_up?
		neighbours << right unless has_wall_right?
		neighbours << down unless has_wall_down?
		neighbours << behind unless has_wall_behind?
		neighbours << front unless has_wall_front?
		neighbours
	end

	def value
		i, j, k = xyz_to_ijk(@x, @y, @z)
		@maze.value(i, j, k)
	end

	def hash
		@hash
	end

	def eql?(object)
		if (object.class == self.class)
			@maze == object.maze && @x == object.x && @y == object.y && @z == object.z
		elsif
			super(object)
		end
	end

	def ==(object)
		self.eql? object
	end

	def !=(object)
		not self.eql? object
	end

	def inspect
		"#<#{self.class}: @maze=#{@maze.inspect}, @x=#{@x}, @y=#{@y}, @z=#{@z}>"
	end
end
