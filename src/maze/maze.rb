require 'maze/maze_cell'

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

	def ==(object)
		self.eql? object
	end

	def inspect
		"#<#{self.class}: @width=#{@width}, @height=#{@height}>"
	end
end
