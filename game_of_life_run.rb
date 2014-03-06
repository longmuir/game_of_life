require_relative 'game_of_life'
require 'curses'
include Curses

@rows = 20
@columns = 20
@cells = Set[[2,2],  [3,3],  [4,1],[4,2],[4,3]]
@game = GameOfLife.new(grid: FixedSizeGrid.new(rows: @rows, columns: @columns), live_cells: @cells)
@iteration = 0

init_screen

loop do
  clear
  @game.each do | cell |
    setpos(cell[0],cell[1])
    addstr "*" 
  end
  setpos(lines-2,0)
  nl
  addstr "Time: #{@iteration} Population: #{@game.count}\n"
  addstr "Press 'x' to quit, any other key to continue..."
  refresh
  exit if getch == "x"
  @game.get_next
  @iteration+=1
end
