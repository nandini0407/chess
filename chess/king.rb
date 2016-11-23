require_relative "piece"
require_relative "stepping_piece"

class King < Piece
  attr_reader :value, :pos, :symbol

  include SteppingPiece

  def initialize(pos, board, symbol)
    @pos = pos
    @board = board
    @symbol = symbol
    @value = "K"
  end

  def moves(pos)
    pos_moves = move_king(pos)
    pos_moves.select { |move| valid_move?(move) }
  end


end
