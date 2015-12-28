require 'maze/maze_cell'

class Maze
	protected
	def allocate(value = 0)
		axis = []
		axis_before = []
		@raw_dimensions.reverse.each_with_index do |dr, dr_index|
			axis = []
			if dr_index == 0
				axis = [value] * dr
			else
				(0...dr).each do
					axis << axis_before.clone
				end
			end
			axis_before = axis
		end
		@matrix = axis
	end

	def make_raw_value(value = 0)
		# process maze cells and walls
		(0...@height_full).each do |i|
			(0...@width_full).each do |j|
				@matrix[i][j] = value
			end
		end
	end

	def make_unconnected
		make_raw_value(1) # fill maze with walls and none cells

		# process only maze cells
		(0...@width).each do |x|
			(0...@height).each do |y|
				i, j = xy_to_ij(x, y)
				@matrix[i][j] = 0 # create empty cell
			end
		end
	end

	public
	attr_reader :dimensions, :width_full, :height_full, :matrix

	def initialize(*dimensions)
		@dimensions = dimensions.map { |d| d.to_i }.freeze
		@raw_dimensions = @dimensions.map { |d| 1 + 2*d }.freeze
		allocate 0
		@hash = @dimensions.reduce(""){ |accum, d| "#{accum}#{d}" }.to_i
	end

	def coords_to_indices(*coords)
		coords.clone.map { |c| 1 + 2 * c }
	end

	def get_raw_value(*indices)
		matrix_aux = @matrix
		indices.each_with_index do |c|
			matrix_aux = matrix_aux[c]
		end
		matrix_aux
	end

	def set_raw_value(*indices)
		matrix_aux = @matrix
		indices = indices.clone
		value = indices.pop
		indices.each_with_index do |c, c_index|
			matrix_aux[c] = value if c_index == indices.length - 1
			matrix_aux = matrix_aux[c]
		end
		matrix_aux
	end

	def set_raw_value_all(value)
		allocate value
	end

	def get_value(*coords)
		get_raw_value *self.coords_to_indices(*coords)
	end

	def set_value(*coords)
		value = coords.pop
		set_raw_value *self.coords_to_indices(*coords).push(value)
	end

	def cell(*coords)
		params = coords.clone
		params.unshift self
		MazeCell.new *params
	end

	def hash
		@hash
	end

	def inspect
		if not @inspect
			d_index = 0
			dimension_list = @dimensions.map { |d| "@d#{d_index+=1}=#{d}" }
			@inspect = "#<#{self.class}: #{dimension_list.join(', ')}>"
		end
		@inspect
	end
end
