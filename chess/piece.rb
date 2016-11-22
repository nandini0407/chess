class Piece
  attr_reader :symbol
  attr_accessor :pos

  def initialize(pos, symbol = nil)
    @pos = pos
    @symbol = symbol
  end

  def valid_move?(pos)
    true
  end

  def moves
    pos_moves = []
    
end
