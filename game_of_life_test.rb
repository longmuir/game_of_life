require_relative 'game_of_life'
require 'test/unit'
require 'set'

class GameOfLifeTest < Test::Unit::TestCase

  def make_new_4x4_game_with_live_cells(live_cells)
    GameOfLife.new(4,4,live_cells)
  end


  def test_cell_is_alive_negative()
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal false, game.cell_is_alive?([1,1])
  end

  def test_cell_is_alive_positive()
    game = make_new_4x4_game_with_live_cells(Set[[1,1]])
    assert_equal true, game.cell_is_alive?([1,1])
  end


  def test_one_dead_cell_stays_alive
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal Set[], game.get_next()
  end

  def test_one_live_cell_dies
    game = make_new_4x4_game_with_live_cells(Set[[1,1]])
    assert_equal Set[], game.get_next()
  end

  #Any live cell with two or 3 neighbours stays alive
  def test_stable_four_stays_alive
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = make_new_4x4_game_with_live_cells(stable_four)
    assert_equal  stable_four, game.get_next()
  end

  #Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  def test_less_than_two_neighbours_dies
    game = make_new_4x4_game_with_live_cells(Set[[1,0], [1,1]])
    assert_equal  Set[], game.get_next()
  end

  #3 live neghbours provides a birth
  def test_empty_cell_three_neighbours_birth_happens
    pre_birth_set = Set[[0,1], [1,0], [1,1]]
    post_birth_set = Set[[0,0],[0,1], [1,0], [1,1]]
    game = make_new_4x4_game_with_live_cells(pre_birth_set)
    assert_equal post_birth_set, game.get_next()
  end


  def test_get_births_none
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal Set[], game.get_births()
  end

  def test_get_births_one
    game = make_new_4x4_game_with_live_cells( Set[[0,1], [1,0], [1,1]])
    assert_equal Set[[0,0]], game.get_births()
  end

  def test_get_cells_with_neighbours_none
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal Set[], game.get_empty_cells_with_neighbours()
  end

  def test_get_cells_with_neighbours_8
    game = make_new_4x4_game_with_live_cells(Set[[1,1]])
    assert_equal Set[[0,0],[0,1],[0,2],
                     [1,0],      [1,2],
                     [2,0],[2,1],[2,2]], game.get_empty_cells_with_neighbours()
  end

  def test_get_live_neighbours_for_cell_empty
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal Set[], game.get_live_neighbours_for_cell([1,1])
  end

  def test_get_neighbours_for_cell_stable4
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = make_new_4x4_game_with_live_cells(stable_four)
    assert_equal Set[[1,2], [2,1], [2,2]], game.get_live_neighbours_for_cell([1,1])
  end

  def test_get_neighbours_for_cell_top_edge
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal Set[[1,0],[1,1],[0,1]], game.get_neighbours_for_cell([0,0])
  end

  def test_get_neighbours_for_cell_bottom_left
    game = make_new_4x4_game_with_live_cells(Set[])
    assert_equal Set[[3,2],[2,2],[2,3]], game.get_neighbours_for_cell([3,3])
  end

  def test_get_survivors_all_die
    game = make_new_4x4_game_with_live_cells(Set[[1,1]])
    assert_equal Set[], game.get_survivors
  end

  def test_get_survivors_stable_four_stays_alive
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = make_new_4x4_game_with_live_cells(stable_four)
    assert_equal stable_four, game.get_survivors
  end


end