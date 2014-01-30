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

class GameOfLife
  attr_accessor :grid, :columns, :rows

  def initialize(input_grid)
    @rows = input_grid.size
    @columns = input_grid[0].size
    @grid = input_grid
  end

  def getNext
    new_grid = @grid.map.with_index do |row, row_index|
               row.map.with_index do |cell, col_index| 
                 cell = evaluateCell(cell, row_index, col_index)
              end
            end
     new_grid
  end

  def evaluateCell(state, row, column)
    new_state = 0
    neighbours = getNeighbourCountForCell(row, column)
    if neighbours == 3 or ( state == 1 and neighbours == 2 )
      new_state = 1
    end
    new_state
  end

  def deadCellShouldComeAlive (state, neighbours)
     ( state == 0 and neighbours == 2 )
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

