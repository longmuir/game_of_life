require_relative 'game_of_life'
puts "testing..."

@rows = 6
@columns = 6

@live_cells = [[2,2],[2,3],[2,4],[2,5],
                [3,2],[3,3],[3,4]]

@game = GameOfLife.new(20,20,@live_cells)

while true
  system("cls")
  for x in 1..@rows
    for y in 1..@columns
      if @game.cell_is_alive?([x,y]) 
        print "*" 
      else
        print "."
      end
    end
    print "\n"
  end
  puts "Press Ctrl+C to quit."
  sleep(1)
  @game.get_next
end