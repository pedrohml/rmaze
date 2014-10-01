require 'maze/maze'

class MazeBTrace < Maze
	def generate
		super
		@matrix[0][0] = 1
		self
	end
end
