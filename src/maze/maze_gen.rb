#!/usr/bin/env ruby

def maze(width=41, height=21, complexity=0.75, density=0.75)
    # Only odd shapes
    shape = [(height / 2) * 2 + 1, (width / 2) * 2 + 1]
    # Adjust complexity and density relative to maze size
    complexity = (complexity * (5 * (shape[0] + shape[1]))).floor
    density = (density * (shape[0] / 2 * shape[1] / 2)).floor
    # Build actual maze
    z = [[1] + [0] * (shape[0]-2) + [1]] * shape[1]
    # Fill borders
	z[0] = [1] * shape[0];
	z[shape[1]-1] = [1] * shape[0];
    # Make aisles
    [0...density].each { |i|
        x, y = rand(shape[1] / 2) * 2, rand(shape[0] / 2) * 2
        z[y][x] = 1
        [0...complexity].each { |j|
            neighbours = []
            if x > 1
				neighbours.push([ y, x - 2 ])
			end
            if x < shape[1] - 2
				neighbours.push([ y, x + 2 ])
			end
            if y > 1
				neighbours.push([ y - 2, x ])
			end
            if y < shape[0] - 2
				neighbours.push([ y + 2, x ])
			end
            if neighbours.size > 0
                y_,x_ = neighbours[rand(neighbours.size)]
                if z[y_][x_] == 0
                    z[y_][x_] = 1
                    z[y_ + (y - y_) / 2][x_ + (x - x_) / 2] = 1
                    x, y = x_, y_
				end
			end
		}
	}
	z.each { |line|
		puts line.join('').gsub('1','#').gsub('0',' ')
	}
	z
end
 
# pyplot.figure(figsize=(10, 5))
# pyplot.imshow(maze(80, 40), cmap=pyplot.cm.binary, interpolation='nearest')
# pyplot.xticks([]), pyplot.yticks([])
# pyplot.show()
