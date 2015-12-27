require 'maze/maze'

class MazeBTrace3D < Maze3D
	protected
	def initialize_matrix
		super
		make_unconnected
	end

	public
	def initialize(width, height, depth)
		super(width, height, depth)
	end

	def between_cells(cell_a, cell_b)
		i_a, j_a, k_a = xyz_to_ijk(cell_a.x, cell_a.y, cell_a.z)
		i_b, j_b, k_b = xyz_to_ijk(cell_b.x, cell_b.y, cell_b.z)
		[(i_a + i_b).abs / 2, (j_a + j_b).abs / 2, (k_a + k_b).abs / 2]
	end

	def generate
		super
		stack = []
		visited_cells = []
		all_index_cells = []
		current_cell = cell(rand(@width), rand(@height), rand(@depth))
		visited_cells.push current_cell
		(0...@width).each do |x|
			(0...@height).each do |y|
				(0...@depth).each do |z|
					all_index_cells << [x, y, z]
				end
			end
		end
		while visited_cells.size != @width * @height * @depth
			neighbours = current_cell.neighbours
			visited_cells.push current_cell
			unvisited_neighbours = (neighbours - visited_cells)
			if !unvisited_neighbours.empty?
				stack.push current_cell
				random_neighbour = unvisited_neighbours.shuffle.shift
				i, j, k = xyz_to_ijk(random_neighbour.x, random_neighbour.y, random_neighbour.z)
				inner_i, inner_j, inner_k = between_cells(current_cell, random_neighbour)
				@matrix[inner_i][inner_j][inner_k] = 0
				current_cell = random_neighbour
				visited_cells.push current_cell
			elsif !stack.empty?
				current_cell = stack.pop
			else
				unvisited_index_cells = all_index_cells - visited_cells.map { |c| [c.x, c.y, c.z] }
				unvisited_index_cell = unvisited_index_cells.shuffle.shift
				current_cell = cell(unvisited_index_cell[0], unvisited_index_cell[1], unvisited_index_cell[2])
				visited_cells.push current_cell
			end
			visited_cells.uniq!
		end
		self
	end
end
