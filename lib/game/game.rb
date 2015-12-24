require 'solver/tree_solver'

class Game
	def initialize(maze)
		@maze = maze
	end

	def select_goal_cell(dificulty)
		dificulty = dificulty.to_sym
		solver = TreeSolver.new(@maze)
		start_x, start_y = 0, 0
		paths = solver.paths(start_x, start_y)
		leafs = {}
		paths.each_leaf do |leaf|
			leafs[leaf.node_depth] = leaf
		end
		depths = leafs.keys.sort
		case dificulty
		when :easy
			selected_depth = depths[(depths.size/4).ceil]
		when :medium
			selected_depth = depths[(depths.size/2).ceil]
		when :hard
			selected_depth = depths.last
		else
			selected_depth = depths[(depths.size/2.0).floor + rand((depths.size/2.0).round)]
		end
		leafs[selected_depth].content
	end

	def generate_goal(dificulty)
		selected_cell = select_goal_cell(dificulty)
		i, j = @maze.xy_to_ij(selected_cell.x, selected_cell.y)
		@maze.matrix[i][j] = 2
		@maze
	end
end
