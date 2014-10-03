describe Maze do
	before do
		@width = rand(10) + 15
		@height = rand(10) + 15
		@maze = Maze.new(@width, @height)
	end

	it '#initialize' do
		expect(@maze.width).to eq(@width)
		expect(@maze.height).to eq(@height)
	end

	it '#value' do
		expect(@maze.value(0, 0)).to eq(0)
	end

	it '#cell' do
		cell = @maze.cell(3, 8)
		expect(cell).to be_a_kind_of(MazeCell)
		expect(cell.maze).to eq(@maze)
		expect(cell.x).to eq(3)
		expect(cell.y).to eq(8)
	end

	it '#xy_to_ij' do
		x, y = 0, 0
		i, j = @maze.xy_to_ij(x, y)
		expect([i, j]).to eq([1, 1])
	end

	it '#generate' do
		expect(@maze.generate).to eq(@maze)
	end

	it '#hash' do
		expect(@maze.hash).to eq("#{@width}#{@height}".to_i)
	end

	it '#inspect' do
		expect(@maze.inspect).to eq("#<Maze: @width=#{@width}, @height=#{@height}>")
	end

	it '#print' do
		allow($stdout).to receive(:puts).exactly(@maze.height_full).times
		@maze.print
	end
end
