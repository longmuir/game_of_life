require_relative 'game_of_life'
puts "testing..."

@rows = 20
@columns = 20


@cells = Set[      [2,2], 
                           [3,3],
               [4,1],[4,2],[4,3]]

@game = GameOfLifeWithFixedSize.new(rows: @rows, columns: @columns, live_cells: @cells)

count = 0
loop do
  count+=1
  system("cls")
  for x in 1..@rows
    for y in 1..@columns
      if @game.cell_is_alive?([x-1,y-1])  
        print "*" 
      else
        print "."
      end
    end
    print "\n"
  end
  puts "Time: #{count} Population: #{@game.count}"
  puts "Press Ctrl+C to quit."
  sleep(0.1)
  @game.get_next
end