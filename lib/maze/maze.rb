require 'maze/maze_cell'

class Maze
	protected
	def initialize_matrix
		@matrix = []
		(0...@height_full).each do
			@matrix << [0]*@width_full
		end
	end

	def make_value(value = 0)
		(0...@height_full).each do |i|
			(0...@width_full).each do |j|
				@matrix[i][j] = value
			end
		end
	end

	def make_unconnected
		make_value(1)
		(0...@width).each do |x|
			(0...@height).each do |y|
				i, j = xy_to_ij(x, y)
				@matrix[i][j] = 0
			end
		end
	end

	public
	attr_reader :mirrored, :width, :height, :width_full, :height_full

	def initialize(width, height)
		@mirrored = false
		@height, @width = height.to_i, width.to_i
		@height_full, @width_full = (1 + 2*@height), (1 + 2*@width)
		initialize_matrix
		@hash = "#{@width}#{@height}".to_i # optimized pre-computed hash
	end

	def matrix
		@matrix.freeze
	end

	def print
		@matrix.each do |row|
			puts row.join(' ').gsub(/0/, ' ').gsub(/1/, '#').gsub(/2/, 'X')
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
		x, y = x % @width, y % @height if @mirrored
		i = 1 + (2 * y)
		j = 1 + (2 * x)
		[i, j]
	end

	def generate
		self
	end

	def hash
		@hash
	end

	def inspect
		"#<#{self.class}: @width=#{@width}, @height=#{@height}>"
	end
end
