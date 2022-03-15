describe Backtrace do
  it '#initialize' do
    maze = Maze.new(rand(10) + 15, rand(10) + 15)
    backtrace = Backtrace.new maze
    expect(backtrace.maze).to eq(maze)
  end

  it '#generate 2d' do
    maze = Maze.new(rand(10) + 15, rand(10) + 15)
    backtrace = Backtrace.new maze
    backtrace.generate
    expect(maze.cells.map { |cell| cell.connected? }).to be_all
  end

  it '#generate Nd' do
    dimensions = ([nil]*(rand(4)+2)).map { |_| 1 + rand(4)  }
    maze = Maze.new *dimensions
    backtrace = Backtrace.new maze
    backtrace.generate
    expect(maze.cells.map { |cell| cell.connected? }).to be_all
  end
end
