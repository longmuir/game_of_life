require_relative 'game_of_life'
require 'test/unit'

class GameOfLifeTest < Test::Unit::TestCase

  def test_OneDeadCellStaysDead
    input_grid = [0]
    output_grid = GameOfLife.new(input_grid).getNext
    assert_equal output_grid, [0]
  end

  def test_OneLiveCellDies
    input_grid = [0]
    output_grid = GameOfLife.new(input_grid).getNext
    assert_equal output_grid, [0]
  end


end

class GridTest < Test::Unit::TestCase

  def test_getNeighbourCountForCell_OneCell
    grid = Grid.new(1,1)
    assert_equal 0, grid.getNeighbourCountForCell(1,1)
  end

  def test_getNeighbourCountForCell_OneCell
    grid = Grid.new(1,1)
    assert_equal 0, grid.getNeighbourCountForCell(0,0)
  end

  def test_getNeighbourCountForCell_6x6_middle_3corners
    grid = Grid.new(3,3)
    grid.makeCellLive(0,0)
    grid.makeCellLive(2,2)
    grid.makeCellLive(0,2)
    assert_equal 3, grid.getNeighbourCountForCell(1,1)
  end

  def test_getNeighbourCountForCell_6x6_toprightedge_1corner
    grid = Grid.new(3,3)
    grid.makeCellLive(1,1)    
    assert_equal 1, grid.getNeighbourCountForCell(0,0)
  end

  def test_getNeighbourCountForCell_6x6_bottomrightedge_1corner
    grid = Grid.new(3,3)
    grid.makeCellLive(1,1)    
    assert_equal 1, grid.getNeighbourCountForCell(2,0)
  end

  def test_getNeighbourCountForCell_6x6_topleftedge_1corner
    grid = Grid.new(3,3)
    grid.makeCellLive(1,1)    
    assert_equal 1, grid.getNeighbourCountForCell(2,2)
  end

  def test_getNeighbourCountForCell_6x6_bottomleftedge_1corner
    grid = Grid.new(3,3)
    grid.makeCellLive(1,1)    
    assert_equal 1, grid.getNeighbourCountForCell(0,2)
  end

  def test_getNeighbourCountForCell_6x6_topedge
    grid = Grid.new(3,3)
    grid.makeCellLive(1,1)    
    assert_equal 1, grid.getNeighbourCountForCell(0,1)
  end

  def test_getNeighbourCountForCell_6x6_bottomedge
    grid = Grid.new(3,3)
    grid.makeCellLive(1,1)    
    assert_equal 1, grid.getNeighbourCountForCell(2,1)
  end

  def test_getNeighbourCountForCell_6x6_leftedge
    grid = Grid.new(3,3)
    grid.makeCellLive(1,1)    
    assert_equal 1, grid.getNeighbourCountForCell(1,0)
  end

  def test_getNeighbourCountForCell_6x6_allsides
    grid = Grid.new(3,3)
    grid.makeCellLive(0,0)
    grid.makeCellLive(0,1)
    grid.makeCellLive(0,2)
    grid.makeCellLive(1,0) 
    grid.makeCellLive(1,2) 
    grid.makeCellLive(2,0)  
    grid.makeCellLive(2,1)  
    grid.makeCellLive(2,2)        
    assert_equal 8, grid.getNeighbourCountForCell(1,1)
  end




end