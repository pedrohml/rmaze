class MazeCell
	attr_reader :maze, :x, :y

	def initialize(maze, x, y)
		@maze = maze
		@x, @y = x, y
		@x, @y = x % @maze.width, y % @maze.height if @maze.mirrored
		@hash = "#{@maze.hash}#{@x}#{@y}".to_i
	end

	def debug
		i, j = @maze.xy_to_ij(@x, @y)
		puts "  #{@maze.value(i - 1, j)}  "
		puts "#{@maze.value(i, j - 1)} #{@maze.value(i, j)} #{@maze.value(i, j + 1)}"
		puts "  #{@maze.value(i + 1, j)}  "
	end

	def left
		MazeCell.new(@maze, @x - 1, @y) if @maze.mirrored || @x > 0
	end

	def up
		MazeCell.new(@maze, @x, @y - 1) if @maze.mirrored || @y > 0
	end

	def right
		MazeCell.new(@maze, @x + 1, @y) if @maze.mirrored || @x < (@maze.width - 1)
	end

	def down
		MazeCell.new(@maze, @x, @y + 1) if @maze.mirrored || @y < (@maze.height - 1)
	end

	def has_wall_left?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i, j - 1) != 0
	end

	def has_wall_up?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i - 1, j) != 0
	end

	def has_wall_right?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i, j + 1) != 0
	end

	def has_wall_down?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i + 1, j) != 0
	end

	def confined?
		has_wall_left? && has_wall_up? && has_wall_right? && has_wall_down?
	end

	def neighbours
		[left, up, right, down].compact
	end

	def hash
		@hash
	end

	def eql?(object)
		if (object.class == self.class)
			 @x == object.x && @y == object.y && @maze == object.maze
		elsif
			super(object)
		end
	end

	def ==(object)
		self.eql? object
	end

	def !=(object)
		!(self.eql? object)
	end

	def inspect
		"#<#{self.class}: @maze=#{@maze.inspect}, @x=#{@x}, @y=#{@y}>"
	end
end
