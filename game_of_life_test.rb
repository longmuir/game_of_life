require_relative 'game_of_life'
require 'test/unit'
require 'set'

class GameOfLifeTest < Test::Unit::TestCase

  def test_one_dead_cell_stays_alive
    game = GameOfLife.new(Set[])
    assert_equal Set[], game.get_next()
  end

  def test_one_live_cell_dies
    game = GameOfLife.new(Set[[1,1]])
    assert_equal Set[], game.get_next()
  end

  #Any live cell with two or 3 neighbours stays alive
  def test_stable_four_stays_alive
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = GameOfLife.new(stable_four)
    assert_equal  stable_four, game.get_next()
  end

  #Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  def test_less_than_two_neighbours_dies
    game = GameOfLife.new(Set[[1,0], [1,1]])
    assert_equal  Set[], game.get_next()
  end

  #3 live neghbours provides a birth
  def test_empty_cell_three_neighbours_birth_happens
    pre_birth_set = Set[[0,1], [1,0], [1,1]]
    post_birth_set = Set[[0,0],[0,1], [1,0], [1,1]]
    game = GameOfLife.new(pre_birth_set)
    assert_equal post_birth_set, game.get_next()
  end


  def test_get_births_none
    game = GameOfLife.new(Set[])
    assert_equal Set[], game.get_births()
  end

  def test_get_births_one
    game = GameOfLife.new( Set[[0,1], [1,0], [1,1]])
    assert_equal Set[[0,0]], game.get_births()
  end

  def test_get_cells_with_neighbours_none
    game = GameOfLife.new(Set[])
    assert_equal Set[], game.get_cells_with_neighbours()
  end

  def test_get_cells_with_neighbours_8
    game = GameOfLife.new(Set[[1,1]])
    assert_equal Set[[0,0],[0,1],[0,2],
                     [1,0],      [1,2],
                     [2,0],[2,1],[2,2]], game.get_cells_with_neighbours()
  end

  def test_get_live_neighbours_for_cell_empty
    game = GameOfLife.new(Set[])
    assert_equal Set[], game.get_live_neighbours_for_cell([1,1])
  end

  def test_get_neighbours_for_cell_stable4
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = GameOfLife.new(stable_four)
    assert_equal Set[[1,2], [2,1], [2,2]], game.get_live_neighbours_for_cell([1,1])
  end

  def test_get_survivors_all_die
    game = GameOfLife.new(Set[[1,1]])
    assert_equal Set[], game.get_survivors
  end

  def test_get_survivors_stable_four_stays_alive
    stable_four = Set[[1,1], [1,2], [2,1], [2,2]]
    game = GameOfLife.new(stable_four)
    assert_equal stable_four, game.get_survivors
  end


end