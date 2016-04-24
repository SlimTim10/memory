class Card
  attr_accessor :symbol, :visible
  
  def initialize(symbol)
    @symbol = symbol
    @visible = false
  end
end
