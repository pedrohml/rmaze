require 'maze/maze'

class MazeBTrace < Maze
	def initialize(width, height)
		super(width, height)
		initialize_maze
	end

	def initialize_maze
		(0...@height_full).each do |i|
			(0...@width_full).each do |j|
				@matrix[i][j] = 1
			end
		end
		(0...@width).each do |x|
			(0...@height).each do |y|
				i, j = xy_to_ij(x, y)
				@matrix[i][j] = 0
			end
		end
	end

	def between_cells(cell_a, cell_b)
		i_a, j_a = xy_to_ij(cell_a.x, cell_a.y)
		i_b, j_b = xy_to_ij(cell_b.x, cell_b.y)
		[(i_a + i_b).abs / 2, (j_a + j_b).abs / 2]
	end

	def generate
		super
		stack = []
		visited_cells = []
		all_index_cells = []
		current_cell = cell(0, 0)
		visited_cells.push current_cell
		(0...@width).each do |x|
			(0...@height).each do |y|
				all_index_cells << [x, y]
			end
		end
		trail = true
		while visited_cells.size != @width * @height
			neighbours = current_cell.neighbours
			visited_cells.push current_cell
			unvisited_neighbours = (neighbours - visited_cells)
			if !unvisited_neighbours.empty?
				stack.push current_cell
				random_neighbour = unvisited_neighbours.shuffle.shift
				i, j = xy_to_ij(random_neighbour.x, random_neighbour.y)
				@matrix[i][j] = 2 if trail
				inner_i, inner_j = between_cells(current_cell, random_neighbour)
				@matrix[inner_i][inner_j] = 0
				current_cell = random_neighbour
				visited_cells.push current_cell
			elsif !stack.empty?
				current_cell = stack.pop
				trail = false
			else
				unvisited_index_cells = all_index_cells - visited_cells.map { |c| [c.x, c.y] }
				unvisited_index_cell = unvisited_index_cells.shuffle.shift
				current_cell = cell(unvisited_index_cell[0], unvisited_index_cell[0])
				visited_cells.push current_cell
			end
			visited_cells.uniq!
		end
		self
	end
end
