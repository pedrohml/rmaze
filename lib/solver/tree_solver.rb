require 'tree'

class TreeSolver
	attr_reader :maze

	def initialize(maze)
		@maze = maze
	end

	def paths(*coords)
		current_cell = @maze.cell *coords
		root_node = current_node = Tree::TreeNode.new(current_cell.coords.map(&:to_s).join(','), current_cell)
		visited_cells = [current_cell]
		stack_node = []
		stack_cell = []
		while visited_cells.size != @maze.total_cells
			neighbours = current_cell.connected_neighbours
			unvisited_neighbours = neighbours - visited_cells
			if unvisited_neighbours.size == 0
				current_cell = stack_cell.pop
				current_node = stack_node.pop
			elsif unvisited_neighbours.size >= 1
				current_cell = unvisited_neighbours.shift
				stack_cell += unvisited_neighbours
				stack_node += [current_node]*unvisited_neighbours.size
			end
			visited_cells << current_cell
			new_node = Tree::TreeNode.new(current_cell.coords.map(&:to_s).join(','), current_cell)
			current_node << new_node 
			current_node = new_node
		end
		root_node
	end
end
