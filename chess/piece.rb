
require_relative "stepping_piece"
require_relative 'sliding_piece'
require 'singleton'

class Piece
  attr_reader :symbol
  attr_accessor :pos, :board

  def initialize(pos, board, symbol)
    @pos = pos
    @symbol = symbol
    @board = board
  end


  def valid_move?(pos)
    if @board[pos].class == NullPiece || @board[pos].symbol != self.symbol
      return true
    end
    false
  end

  def self.moves(piece)
    piece.legal_moves
  end

end

class Knight < Piece
  attr_reader :value

  include SteppingPiece

  def initialize(pos, board, symbol)
    @value = "N"
    @all_legal_moves = []
    super
  end

end

class King < Piece
  attr_reader :value

  include SteppingPiece

  def initialize(pos, board, symbol)
    @value = "K"
    @all_legal_moves = []
    super
  end
end

class Bishop < Piece
  attr_reader :value

  include SlidingPiece

  def initialize(pos, board, symbol)
    @value = "B"
    @all_legal_moves = []
    @dir = :diagonal
    super
  end
end

class Queen < Piece
  attr_reader :value

  include SlidingPiece

  def initialize(pos, board, symbol)
    @value = "Q"
    @all_legal_moves = []
    @dir = :both
    super
  end
end

class Rook < Piece
  attr_reader :value

  include SlidingPiece

  def initialize(pos, board, symbol)
    @value = "R"
    @all_legal_moves = []
    @dir = :hv
    super
  end
end

class Pawn < Piece
  attr_reader :value

  def initialize(pos, board, symbol)
    @value = "P"
    @all_legal_moves = []
    super
  end

end

class NullPiece < Piece

  include Singleton

  def initialize
    @symbol = " "
  end

end
