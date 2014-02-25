# The Game Of Life Kata - A code kata I'm using to learn some aspects of Ruby.  
# Yes, this problem can be solved in fewer lines of code - aim here is for 
# an elegant, easy to understand solution that uses some of the OO techniques
# from Sandy Metz's POODR book. 
#
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

class GameOfLife < Set

  def initialize(args)
    super(args[:live_cells])
    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end

  def get_next
    replace(get_survivors + get_births)
  end

  def cell_is_alive?(cell)
    include?(cell)
  end

  def get_births
    get_empty_cells_with_neighbours.select do | candidate_cell |
      get_live_neighbours_count_for_cell(candidate_cell) == 3
    end
  end

  def get_empty_cells_with_neighbours
    reduce(Set[]) do |cells_with_neighbours, cell|
      cells_with_neighbours + get_neighbours_for_cell(cell) - self.to_a
    end
  end

  def get_survivors
    select do | cell | 
      [2,3].include?(get_live_neighbours_count_for_cell(cell))
    end
  end

  def get_live_neighbours_count_for_cell(cell)
    (get_neighbours_for_cell(cell) & self.to_a).size
  end

  def get_neighbours_for_cell(cell)
    neighbours = get_possible_neighbours_for_cell(cell).select { |cell| not off_the_map?(cell) }
  end

  def get_possible_neighbours_for_cell(cell)
    neighbour_offsets = Set[[1, -1], [1, 0], [1, 1],
                           [0, -1],         [0, 1],
                           [-1,-1], [-1,0], [-1,1]]

    neighbour_offsets.map {|cell_offset| [cell_offset[0]+cell[0],cell_offset[1]+cell[1]] }
  end

  def off_the_map?(cell)
    raise NotImplementedError, "This #{self.class} cannot respond to off_the_map?"
  end

end

class GameOfLifeWithInfiniteSize < GameOfLife
  def post_initialize(args)
    @rows = args[:rows]
    @columns = args[:columns]
  end

  def off_the_map?(cell)
    return (cell[0] < 0 || cell[1] < 0)
  end
end

class GameOfLifeWithFixedSize < GameOfLife
  def post_initialize(args)
    @rows = args[:rows]
    @columns = args[:columns]
  end
 
  def off_the_map?(cell)
    return (cell[0] < 0 || 
            cell[1] < 0 || 
            cell[0] > @rows-1 ||
            cell[1] > @columns-1)
  end

end

