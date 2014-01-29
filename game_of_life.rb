#My first attempt at the Game Of Life Kata - I will evolve this code 
#over a few days.

# Your task is to write a program to calculate the next
# generation of Conway's game of life, given any starting
# position. You start with a two dimensional grid of cells, 
# where each cell is either alive or dead. The grid is finite, 
# and no life can exist off the edges. When calculating the 
# next generation of the grid, follow these four rules:

# 1. Any live cell with fewer than two live neighbours dies, 
#    as if caused by underpopulation.
# 2. Any live cell with more than three live neighbours dies, 
#    as if by overcrowding.
# 3. Any live cell with two or three live neighbours lives 
#    on to the next generation.
# 4. Any dead cell with exactly three live neighbours becomes 
#    a=end
#  live cell.

require 'matrix'

class Grid
  attr_accessor :grid, :columns, :rows

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @grid = Array.new(rows) { Array.new(columns, 0) }
  end

  def makeCellLive(row, column)
    self.grid[row][column]  = 1
  end

  #should this method be in this class?
  def getNeighbourCountForCell(row, column)
    neighbours = 0
    #This block could be improved a lot with the methods.
    neighbours += top_right_neighbour(row, column)
    neighbours += top_left_neighbour(row, column)
    neighbours += bottom_right_neighbour(row, column)
    neighbours += bottom_left_neighbour(row, column)
    neighbours += bottom(row, column)
    neighbours += top(row, column)
    neighbours += left(row, column)
    neighbours += right(row, column)
    neighbours
  end

#These methods could be improved a lot... lots of duplication

  def bottom(row, column)
    if (row+1 < self.rows)
      return self.grid[row+1][column]
    else
      return 0
    end
  end

  def top(row, column)
    if (row > 0)
      return self.grid[row-1][column]
    else
      return 0
    end
  end

  def left(row, column)
    if (column > 0)
      return self.grid[row][column-1]
    else
      return 0
    end
  end

  def right(row, column)
    if (column+1 < self.columns)
      return self.grid[row][column+1]
    else
      return 0
    end
  end


  def top_right_neighbour(row, column)
    if(row != 0 and column+1 < self.columns)
      return self.grid[row-1][column+1]
    else 
      return 0
    end
  end

  def top_left_neighbour(row, column)
    if(row+1 < self.rows and column+1 < self.columns)
      return self.grid[row+1][column+1]
    else 
      return 0
    end
  end

  def bottom_right_neighbour(row, column)
    if(row != 0 and column != 0)
      return self.grid[row-1][column-1]
    else 
      return 0
    end
  end

  def bottom_left_neighbour(row, column)
    if(row +1 < self.rows and column != 0)
      return self.grid[row+1][column-1]
    else 
      return 0
    end
  end


end


class GameOfLife

  attr_accessor :input_grid, :output_grid

  def initialize(input_grid)
    @input_grid = input_grid
    @output_grid = []
  end

  def getNext
    if @input_grid.size == 1 
      @output_grid = [0]
    end
    @output_grid
  end

end

