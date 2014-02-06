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

  def initialize(live_cells)
    @live_cells = live_cells
  end

  def get_next
    new_live_cells = get_survivors + get_births
    @live_cells = new_live_cells
  end

   def get_births
    births = Set[]
    empty_cells_with_neighbours = get_cells_with_neighbours - @live_cells
    empty_cells_with_neighbours.each do |candidate_cell|
      if get_live_neighbours_for_cell(candidate_cell).size == 3
        births.add(candidate_cell)
      end
    end
    births
   end

  def get_cells_with_neighbours
    cells_with_neighbours = Set[]
    @live_cells.each do |cell|
      cells_with_neighbours+=get_neighbours_for_cell(cell)
    end
    cells_with_neighbours
  end

  def get_survivors
    survivors = Set[]

    @live_cells.each do |cell|
      neighbour_count = get_live_neighbours_for_cell(cell).size
      if  neighbour_count == 2 or neighbour_count == 3 
        survivors.add([cell[0],cell[1]])
      end
    end

    survivors
  end

  def get_neighbours_for_cell(cell)
    neighbour_deltas = Set[[1, -1], [1, 0], [1, 1],
                           [0, -1],         [0, 1],
                           [-1,-1], [-1,0], [-1,1]]
    neighbours = Set[]
    neighbour_deltas.each do |cell_delta|
      neighbours.add([cell_delta[0]+cell[0],cell_delta[1]+cell[1]])
    end
    neighbours
  end

  def get_live_neighbours_for_cell(cell)
    potential_neighbours = get_neighbours_for_cell(cell)
    potential_neighbours & @live_cells
  end


end

