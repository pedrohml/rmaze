require 'maze/maze_cell_3d'

class Maze3D
	protected
	def initialize_matrix
		@matrix = []
		(0...@height_full).each do
			depth_row = [0] * @depth
			@matrix << ([depth_row] * @width_full).map { |width_row| width_row.clone } # clone to duplicate object content
		end
	end

	def make_raw_value(value = 0)
		# process maze cells and walls
		(0...@height_full).each do |i|
			(0...@width_full).each do |j|
				(0...@depth_full).each do |k|
					@matrix[i][j][k] = value
				end
			end
		end
	end

	def make_unconnected
		make_raw_value(1) # fill maze with walls, no empty cells

		# process only maze cells
		(0...@width).each do |x|
			(0...@height).each do |y|
				(0...@depth).each do |z|
					i, j, k = xyz_to_ijk(x, y, z)
					@matrix[i][j][k] = 0 # create empty cell
				end
			end
		end
	end

	public
	attr_reader :mirrored, :width, :height, :depth, :width_full, :height_full, :depth_full, :matrix

	def initialize(width, height, depth)
		@mirrored = false
		@height, @width, @depth = height.to_i, width.to_i, depth.to_i
		@height_full, @width_full, @depth_full = (1 + 2*@height), (1 + 2*@width), (1 + 2*@depth)
		initialize_matrix
		
		# optimized pre-computed hash
		@hash = "#{@width}#{@height}#{@depth}".to_i
	end

	def value(i, j, k)
		@matrix[i][j][k]
	end

	def cell(x, y, z)
		MazeCell3D.new(self, x, y, z)
	end

	def xyz_to_ijk(x, y, z)
		x, y, z = x % @width, y % @height, z % @depth if @mirrored
		i = 1 + (2 * y)
		j = 1 + (2 * x)
		k = 1 + (2 * z)
		[i, j, k]
	end

	def generate
		self
	end

	def hash
		@hash
	end

	def print(z = 0)
		puts self.view z
		self
	end

	def raw_print(z = 0)
		puts self.raw_view z
		self
	end

	def print_all
		(0...@depth_full).each_with_index do |k, idx|
			self.print k
			puts if idx < @depth_full - 1
		end
		self
	end

	def raw_print_all
		(0...@depth_full).each_with_index do |k, idx|
			self.raw_print k
			puts if idx < @depth_full - 1
		end
		self
	end

	def view(k = 0)
		output = ''
		@matrix.each_with_index do |row, idx|
			slice = row.map { |d| d[k] }
			output += slice.join(' ').gsub(/0/, ' ').gsub(/1/, '#').gsub(/2/, 'X')
			output += "\n" if idx < @matrix.length - 1
		end
		output
	end

	def raw_view(k = 0)
		output = ''
		@matrix.each_with_index do |row, idx|
			slice = row.map { |d| d[k] }
			output += JSON.unparse(slice)
			output += "\n" if idx < @matrix.length - 1
		end
		output
	end

	def to_s
		self.inspect
	end

	def inspect
		"#<#{self.class}: @width=#{@width}, @height=#{@height}, @depth=#{@depth}>"
	end
end
