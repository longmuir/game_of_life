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

require 'set'

#This code suffers from primitive obsession... cell, grid use primitive types
class GameOfLife

  def initialize(rows, columns, live_cells)
    @live_cells = live_cells
    @rows = rows
    @columns = columns
  end

  def get_next
    new_live_cells = get_survivors + get_births
    @live_cells = new_live_cells
  end

  def cell_is_alive?(cell)
    @live_cells.include?(cell)
  end

   def get_births
    births = get_empty_cells_with_neighbours.select do | candidate_cell |
      get_live_neighbours_for_cell(candidate_cell).size == 3
    end
    births.to_set
   end

  def get_empty_cells_with_neighbours
    @live_cells.reduce(Set[]) do |cells_with_neighbours, cell|
      get_neighbours_for_cell(cell) - @live_cells
    end
  end

  def get_survivors
    survivors = @live_cells.select do | cell | 
      [2,3].include?(get_live_neighbours_for_cell(cell).size)
    end
    survivors.to_set
  end

  def get_neighbours_for_cell(cell)
    get_possible_neighbours_for_cell(cell).select { |cell| !off_the_map(cell) }.to_set
  end

  def get_possible_neighbours_for_cell(cell)
    neighbour_deltas = Set[[1, -1], [1, 0], [1, 1],
                           [0, -1],         [0, 1],
                           [-1,-1], [-1,0], [-1,1]]

    neighbour_deltas.map {|cell_delta| [cell_delta[0]+cell[0],cell_delta[1]+cell[1]] }
  end


  def get_live_neighbours_for_cell(cell)
    get_neighbours_for_cell(cell) & @live_cells
  end

  def off_the_map(cell)
    return (cell[0] < 0 || 
            cell[1] < 0 || 
            cell[0] > @rows-1 ||
            cell[1] > @columns-1)
  end

end

