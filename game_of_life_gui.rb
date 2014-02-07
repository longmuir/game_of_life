Shoes.app do
  stack do
      @live_cell = background green
      @live_cell.style width: 100, height: 100
      @tick_button = button "Tick", width: 80, height: 40
  end
end