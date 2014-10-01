require 'maze/maze_cell'

class Maze
	protected
	attr_reader :matrix

	public
	attr_reader :mirrored, :width, :height, :width_full, :height_full

	def initialize(width, height)
		@mirrored = false
		@height, @width = height, width
		@height_full, @width_full = (1 + 2*@height), (1 + 2*@width)
		@matrix = []
		(0...@height_full).each do
			@matrix << [0]*@width_full
		end
	end

	def debug
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
		"#{@width}000#{@height}".to_i
	end

	def eql?(object)
		if (object.class == self.class && object.hash == self.hash)
			@matrix.flatten.join('') == object.matrix.flatten.join('')
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
		"#<#{self.class}: @width=#{@width}, @height=#{@height}>"
	end
end
