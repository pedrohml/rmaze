#!/usr/bin/env ruby

class MazeCell
	attr_reader :x, :y

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

	def neighbours
		[left, up, right, down]
	end
end

class Maze
	protected
	attr_reader :matrix

	public
	attr_reader :width, :height

	def initialize(width, height)
		@height, @width = height, width
		@matrix = []
		(0...(1 + 2*@height)).each do
			@matrix << [0]*(1 + 2*@width)
		end
	end

	def debug
		@matrix.each do |row|
			puts row.join(' ')
		end
		self
	end

	def value(i, j)
		@matrix[i][j]
	end

	def cell(x, y)
		MazeCell.new(self, x, y)
	end

	def xy_to_ij(x, y)
		x = x % @width
		y = y % @height
		i = 1 + (2 * y)
		j = 1 + (2 * x)
		[i, j]
	end

	def generate
		self
	end

	def eql?(object)
		if (object.class == self.class)
			@matrix.flatten.join('') == object.matrix.flatten.join('')
		elsif
			super(object)
		end
	end

	def inspect
		"#<#{self.class}: @width=#{@width}, @height=#{@height}>"
	end
end

class MazeBTrace < Maze
	def generate
		super
		@matrix[0][0] = 1
		self
	end
end
