require_relative 'game_of_life'
require 'test/unit'

class GameOfLifeTest < Test::Unit::TestCase

  def makeGrid(rows, columns)
    Array.new(rows) { Array.new(columns, 0) }
  end


  def test_OneDeadCellStaysDead
    input_game = [[0]]
    output_game = GameOfLife.new(input_game).getNext
    assert_equal output_game, [[0]]
  end

  def test_OneLiveCellDies
    input_game = [[0]]
    output_game = GameOfLife.new(input_game).getNext
    assert_equal output_game, [[0]]
  end

  #Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  def test_3x3game_LessThanTwoNeighbourDies
    input_game = [[0,1,0],
                  [0,1,0],
                  [0,0,0]]
    expected_game = [[0,0,0],
                     [0,0,0],
                     [0,0,0]]
    output_game = GameOfLife.new(input_game).getNext
    assert_equal  expected_game, output_game
  end

   #Any dead cell with exactly three live neighbours becomes a live cell.
  def test_2x2game_Exactly3NeighboursComesAlive
    input_game = [[1,1],
                  [1,0]]
    expected_game = [[1,1],
                     [1,1]]
    output_game = GameOfLife.new(input_game).getNext
    assert_equal  expected_game, output_game
  end

     #Any dead cell with exactly three live neighbours becomes a live cell.
  def test_2x2game_Exactly2NeighboursStaysAlive
    input_game = [[1,1],
                  [0,1]]
    expected_game = [[1,1],
                     [1,1]]
    output_game = GameOfLife.new(input_game).getNext
    assert_equal  expected_game, output_game
  end

  #Any live cell with more than three live neighbours dies, as if by overcrowding.
  def test_2x2game_MoreThan3NeighboursDies
    input_game = [[1,1,0],
                  [1,1,0],
                  [1,0,0]]
    expected_game = [[1,1,0],
                     [0,0,0],
                     [1,1,0]]
    output_game = GameOfLife.new(input_game).getNext
    assert_equal  expected_game, output_game
  end

  def 

  #Internal method tests

  def test_getNeighbourCountForCell_OneCell
    game = GameOfLife.new makeGrid(1,1)
    assert_equal 0, game.getNeighbourCountForCell(1,1)
  end

  def test_getNeighbourCountForCell_OneCell
    game = GameOfLife.new makeGrid(1,1)
    assert_equal 0, game.getNeighbourCountForCell(0,0)
  end

  def test_getNeighbourCountForCell_3x3_middle_3corners
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(0,0)
    game.makeCellLive(2,2)
    game.makeCellLive(0,2)
    assert_equal 3, game.getNeighbourCountForCell(1,1)
  end

  def test_getNeighbourCountForCell_3x3_toprightedge_1corner
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(1,1)    
    assert_equal 1, game.getNeighbourCountForCell(0,0)
  end

  def test_getNeighbourCountForCell_3x3_bottomrightedge_1corner
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(1,1)    
    assert_equal 1, game.getNeighbourCountForCell(2,0)
  end

  def test_getNeighbourCountForCell_3x3_topleftedge_1corner
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(1,1)    
    assert_equal 1, game.getNeighbourCountForCell(2,2)
  end

  def test_getNeighbourCountForCell_3x3_bottomleftedge_1corner
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(1,1)    
    assert_equal 1, game.getNeighbourCountForCell(0,2)
  end

  def test_getNeighbourCountForCell_3x3_topedge
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(1,1)    
    assert_equal 1, game.getNeighbourCountForCell(0,1)
  end

  def test_getNeighbourCountForCell_3x3_bottomedge
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(1,1)    
    assert_equal 1, game.getNeighbourCountForCell(2,1)
  end

  def test_getNeighbourCountForCell_3x3_leftedge
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(1,1)    
    assert_equal 1, game.getNeighbourCountForCell(1,0)
  end

   def test_getNeighbourCountForTopRow_3x3_allsides
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(0,0)
    game.makeCellLive(0,1)
    game.makeCellLive(0,2)        
    assert_equal 3, game.getNeighbourCountForCell(1,1)
  end

  def test_getNeighbourCountForCell_3x3_allsides
    game = GameOfLife.new makeGrid(3,3)
    game.makeCellLive(0,0)
    game.makeCellLive(0,1)
    game.makeCellLive(0,2)
    game.makeCellLive(1,0) 
    game.makeCellLive(1,2) 
    game.makeCellLive(2,0)  
    game.makeCellLive(2,1)  
    game.makeCellLive(2,2)        
    assert_equal 8, game.getNeighbourCountForCell(1,1)
  end




end