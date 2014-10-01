class MazeCell
	attr_reader :maze, :x, :y

	def initialize(maze, x, y)
		@maze = maze
		@x, @y = x % @maze.width, y % @maze.height
	end

	def debug
		i, j = @maze.xy_to_ij(@x, @y)
		puts "  #{@maze.value(i - 1, j)}  "
		puts "#{@maze.value(i, j - 1)} #{@maze.value(i, j)} #{@maze.value(i, j + 1)}"
		puts "  #{@maze.value(i + 1, j)}  "
	end

	def left
		MazeCell.new(@maze, @x - 1, @y)
	end

	def up
		MazeCell.new(@maze, @x, @y - 1)
	end

	def right
		MazeCell.new(@maze, @x + 1, @y)
	end

	def down
		MazeCell.new(@maze, @x, @y + 1)
	end

	def wall_left?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i, j - 1) != 0
	end

	def wall_up?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i - 1, j) != 0
	end

	def wall_right?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i, j + 1) != 0
	end

	def wall_down?
		i, j = @maze.xy_to_ij(@x, @y)
		@maze.value(i + 1, j) != 0
	end
end
