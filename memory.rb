require "./grid"

# Time to show flipped cards (seconds)
DELAY_TIME = 2

def clear_screen
  if ENV['OS'] == "Windows_NT"
    system("cls")
  else
    system("clear")
  end
end

grid = Grid.new

while !grid.game_over?
  clear_screen
  grid.display
  grid.choose_card(1)
  clear_screen
  grid.display
  grid.choose_card(2)
  clear_screen
  grid.display
  grid.check_match
  sleep(DELAY_TIME)
end

puts "You won! (You can't lose anyway)"
