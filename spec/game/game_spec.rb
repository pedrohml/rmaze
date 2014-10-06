describe Game do
	before do
		@maze = MazeBTrace.new(8, 8)
		@maze.generate
		@game = Game.new(@maze)
	end

	it '#select_goal_cell' do
		selected_cell = @game.select_goal_cell(:hard)
		expect([selected_cell.x, selected_cell.y]).not_to eq([0, 0])
		expect(selected_cell.connected_neighbours.size).to eq(1)
	end

	it '#generate_goal :easy' do
		maze = @game.generate_goal(:easy)
		expect(maze.matrix.flatten).to include(2)
	end

	it '#generate_goal :easy' do
		maze = @game.generate_goal(:medium)
		expect(maze.matrix.flatten).to include(2)
	end

	it '#generate_goal :easy' do
		maze = @game.generate_goal(:hard)
		expect(maze.matrix.flatten).to include(2)
	end

	it '#generate_goal :easy' do
		maze = @game.generate_goal(:random)
		expect(maze.matrix.flatten).to include(2)
	end
end
