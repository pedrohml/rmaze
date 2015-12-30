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
					axis << Marshal.load(Marshal.dump(axis_before)) # deep clone
				end
			end
			axis_before = axis
		end
		@matrix = axis
	end

    def set_between_cells(cell_a, cell_b, value)
        indices = between_cells cell_a, cell_b
        params = indices.clone
        params.push value
        set_raw_value *params
        indices
    end

    def evaluate_indices(dim_sizes)
        matrix_aux = @matrix
        indices = []
        stack = []
        begin
            if not stack.empty? and stack.last >= dim_sizes[stack.length - 1]
                stack.pop
                stack[-1] += 1 if not stack.empty?
            elsif stack.length < dim_sizes.length - 1
                matrix_before = matrix_aux
                stack.push 0
                matrix_aux = matrix_aux[stack.last]
            else
                (0...dim_sizes.last).each { |d| indices.push(stack + [d]) }
                stack[-1] += 1
            end
        end until stack.empty?
        indices
    end

	public
	attr_accessor :matrix
	attr_reader :dimensions

	def initialize(*dimensions)
		@dimensions = dimensions.map { |d| d.to_i }.freeze
		@raw_dimensions = @dimensions.map { |d| 1 + 2*d }.freeze
		allocate 0
		@hash = @dimensions.reduce(""){ |accum, d| "#{accum}#{d}" }.to_i
	end

	def self.from_array(matrix)
		dimensions = []
		matrix_aux = matrix
		while matrix_aux.is_a? Array
			dimensions.push matrix_aux.length
			matrix_aux = matrix_aux[0]
		end
		maze = Maze.new *dimensions
		maze.matrix = Marshal.load(Marshal.dump(matrix)) # deep clone
		maze
	end

    def total_cells
        dimensions.reduce(1) { |accum, d| accum*d }
    end

    def total_raw
        dimensions.reduce(1) { |accum, d| accum*(1 + 2*d) }
    end

	def coords_to_indices(*coords)
		coords.map { |c| 1 + 2 * c }
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
        coords = coords.clone
		value = coords.pop
		set_raw_value *self.coords_to_indices(*coords).push(value)
	end

	def cell(*coords)
		params = coords.clone
		params.unshift self
		MazeCell.new *params
	end

    def cells
        evaluate_indices(@dimensions).map { |coord| cell *coord }
    end

	def between_cells(cell_a, cell_b)
		indices_a = coords_to_indices *cell_a.coords
		indices_b = coords_to_indices *cell_b.coords
        indices_a.zip(indices_b).map { |pair| (pair[0] + pair[1]) / 2.0 }
	end

    def connect_cells(cell_a, cell_b)
        set_between_cells cell_a, cell_b, 0
    end

    def disconnect_cells(cell_a, cell_b)
        set_between_cells cell_a, cell_b, 1
    end

	def to_json
		JSON.unparse @matrix
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
