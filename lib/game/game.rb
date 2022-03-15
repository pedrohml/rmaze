require 'solver/tree_solver'

class Game
    def initialize(maze)
        @maze = maze
    end

    def select_goal_cell(dificulty)
        dificulty = dificulty.to_sym
        solver = TreeSolver.new @maze
        start_coords = [0]*@maze.dimensions.length
        paths = solver.paths *start_coords
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
        selected_cell = select_goal_cell dificulty
        indices = @maze.coords_to_indices *selected_cell.coords
        params = indices.clone
        params.push 2
        @maze.set_raw_value *params
        @maze
    end
end
