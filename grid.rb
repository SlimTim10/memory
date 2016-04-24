require "./card"

class Grid
  MAX_AREA = 16
  SYMBOL_LIST = ["!", "@", "#", "$", "%", "&", "+", "?"]
  
  def initialize
    @width = 0
    @height = 0
    @first_choice = nil
    @second_choice = nil
    
    while !valid_size?(@width, @height)
      print "Set width: "
      @width = gets.chomp.to_i
      print "Set height: "
      @height = gets.chomp.to_i
    end

    @cards = generate_cards(SYMBOL_LIST, @width * @height)
    @cards.shuffle!
  end

  def display
    (0...@height).each do |row|
      (1..@width).each do |col|
        num = col + (row * @width)
        index = num - 1
        print "|"
        if @cards[index].visible
          print "#{@cards[index].symbol}#{@cards[index].symbol}"
        else
          print num.to_s.rjust(2, "0")
        end
      end
      puts "|"
    end
    puts
  end

  def choose_card(choice)
    num = 0
    while !valid_card?(num)
      print "Choose a card: "
      num = gets.chomp.to_i
      if !valid_card?(num)
        puts "Choose a different card!"
      end
    end
    
    if choice == 1
      @first_choice = num
    else
      @second_choice = num
    end
    
    @cards[num - 1].visible = true
  end

  def check_match
    if @second_choice.nil?
      return
    end
    if @cards[@first_choice - 1].symbol == @cards[@second_choice - 1].symbol
      @cards[@first_choice - 1].visible = true
      @cards[@second_choice - 1].visible = true
    else
      @cards[@first_choice - 1].visible = false
      @cards[@second_choice - 1].visible = false
      @first_choice = nil
      @second_choice = nil
    end
  end

  def game_over?
    @cards.each do |card|
      if card.visible == false
        return false
      end
    end
    return true
  end

  private

  def valid_size?(width, height)
    area = width * height
    if area < 4 || area > 16
      return false
    end
    if !area.even?
      return false
    end
    return true
  end

  def generate_cards(symbol_list, area)
    cards = []
    num_symbols = area / 2
    num_symbols.times do |i|
      cards.push(Card.new(symbol_list[i]))
      cards.push(Card.new(symbol_list[i]))
    end
    cards
  end

  def valid_card?(n)
    return n > 0 &&
           n <= @cards.length &&
           @cards[n-1].visible == false
  end
end
