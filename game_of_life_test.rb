require_relative 'game_of_life'
require 'test/unit'
require 'set'

class GameOfLifeTest < Test::Unit::TestCase

  def make_new_4x4_game_with_live_cells(live_cells)
    GameOfLife.new(grid: FixedSizeGrid.new(rows: 4, columns: 4), live_cells: live_cells)
  end

  def test_cell_is_alive
    game = make_new_4x4_game_with_live_cells(Set[[1,1]])
    assert_equal false, game.cell_is_alive?([0,0])
    assert_equal true, game.cell_is_alive?([1,1])
  end

  def test_next_one_live_cell_dies
    game = make_new_4x4_game_with_live_cells(Set[[1,1]])
    assert_equal Set[], game.get_next
  end

  def test_next_one_cell_born_rest_die
    game = make_new_4x4_game_with_live_cells( Set[[0,0], [2,0], [0,2]])
    assert_equal Set[[1,1]], game.get_next
  end

  def test_next_less_than_two_neighbours_dies
    game = make_new_4x4_game_with_live_cells(Set[[1,0], [1,1]])
    assert_equal  Set[], game.get_next()
  end

  def test_next_stable_four_stays_alive
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = make_new_4x4_game_with_live_cells(stable_four)
    assert_equal  stable_four, game.get_next
  end

  def test_nest_empty_cell_three_neighbours_birth_happens
    pre_birth_set = Set[[0,1], [1,0], [1,1]]
    post_birth_set = Set[[0,0],[0,1], [1,0], [1,1]]
    game = make_new_4x4_game_with_live_cells(pre_birth_set)
    assert_equal post_birth_set, game.get_next
  end

  def test_next_blinker_formation
    horizontal_bar = Set[[1,0], [1,1], [1,2]]
    vertical_bar = Set[[0,1], [1,1], [2,1]]
    game = make_new_4x4_game_with_live_cells(horizontal_bar)
    assert_equal vertical_bar, game.get_next
    assert_equal horizontal_bar, game.get_next
    assert_equal vertical_bar, game.get_next
  end

  def make_new_10x10_game_with_live_cells(live_cells)
    GameOfLife.new(grid: FixedSizeGrid.new(rows: 10, columns: 10), live_cells: live_cells)
  end

  def test_next_beehive_formation
    cells = Set[     [2,2], [2,3], 
                [3,1],             [3,4],
                     [4,2], [4,3]]
    game = make_new_10x10_game_with_live_cells(cells)
    assert_equal cells, game.get_next
    assert_equal cells, game.get_next
  end

  def test_next_glider_formation
    start = Set[      [2,2], 
                           [3,3],
               [1,4],[2,4],[3,4]]
    
    step1 = Set[  [1,3],     [3,3],  
                       [2,4],[3,4],
                       [2,5]]
    step2 = Set[            [3,3], 
                [1,4],      [3,4],
                      [2,5],[3,5]]
    game = make_new_10x10_game_with_live_cells(start)
    assert_equal step1, game.get_next
    assert_equal step2, game.get_next

  end

  #Internal tests - should refactor or remove
  def test_get_live_neighbours_for_cell_stable4
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = make_new_4x4_game_with_live_cells(stable_four)
    assert_equal 3, game.get_live_neighbours_count_for_cell([1,1])
  end

  def test_get_empty_cells_with_neighbours_none
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal Set[], game.get_empty_cells_with_neighbours
  end

  def test_get_empty_cells_with_neighbours_8
    game = make_new_4x4_game_with_live_cells(Set[[1,1]])
    assert_equal Set[[0,0],[0,1],[0,2],
                     [1,0],      [1,2],
                     [2,0],[2,1],[2,2]], game.get_empty_cells_with_neighbours
  end

end

class FixedSizeGridTest < Test::Unit::TestCase
  def setup
    @grid = FixedSizeGrid.new(rows:4, columns:4)
  end

  def test_get_neighbours_for_cell_top_edge
    assert_equal [[1,0],[1,1],[0,1]], @grid.get_neighbours_for_cell([0,0])
  end

  def test_get_neighbours_for_cell_bottom_left
    assert_equal [[3,2],[2,2],[2,3]], @grid.get_neighbours_for_cell([3,3])
  end

  def test_off_the_map_is_true
    assert_equal true, @grid.off_the_map?([-1,0]) 
    assert_equal true, @grid.off_the_map?([4,4])
  end

  def test_off_the_map_is_false
    assert_equal false, @grid.off_the_map?([0,0]) 
    assert_equal false, @grid.off_the_map?([3,3])
  end

end

class InfiniteGridTest < Test::Unit::TestCase
  def setup
    @grid = InfiniteGrid.new
  end

  def test_off_the_map_is_true
    assert_equal true, @grid.off_the_map?([-1,0])
  end

  def test_off_the_map_is_false
    assert_equal false, @grid.off_the_map?([0,0])
    assert_equal false, @grid.off_the_map?([1000,1000])
  end
end