require 'maze/maze'

class Backtrace
    attr_reader :maze

	def initialize(maze)
        @maze = maze
	end

	def generate
		stack = []
		visited_cells = []
		all_cells = []
        @maze.set_raw_value_all 1
        all_cells = @maze.cells

        all_cells.each do |cell|
            @maze.set_value *cell.coords.clone.push(0)
        end

		current_cell = @maze.cell *@maze.dimensions.map { |d| rand(d) }
		visited_cells.push current_cell

		while visited_cells.size != @maze.total_cells
			neighbours = current_cell.neighbours
			visited_cells.push current_cell
			unvisited_neighbours = (neighbours - visited_cells)
			if !unvisited_neighbours.empty?
				stack.push current_cell
				random_neighbour = unvisited_neighbours.shuffle.shift
                @maze.connect_cells current_cell, random_neighbour
				current_cell = random_neighbour
				visited_cells.push current_cell
			elsif !stack.empty?
				current_cell = stack.pop
			else
				unvisited_index_cells = all_cells - visited_cells
				unvisited_index_cell = unvisited_index_cells.shuffle.shift
				current_cell = unvisited_index_cell
				visited_cells.push current_cell
			end
			visited_cells.uniq!
		end
		@maze
	end
end
