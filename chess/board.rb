require_relative 'piece'

require 'byebug'

class Board
  attr_reader :grid

  def initialize
    @grid = make_starting_grid
  end

  def move_piece(start_pos, end_pos, piece)
      raise "empty square" if self[start_pos].class == NullPiece
      raise "cannot move there" unless self[start_pos].valid_move?(end_pos)
      moves = Piece.moves(piece)
      return unless moves.include?(end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = NullPiece.instance
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x,y = pos
    @grid[x][y] = piece
  end

  def valid_pos?(pos)
    x,y = pos
    return false unless x.between?(0,7) && y.between?(0,7)
    true
  end

  def in_check?(symbol)
    if symbol == :w
      opposite_symbol = :b
    else
      opposite_symbol == :w
    end
    enemy_team = get_pieces(opposite_symbol)
    @grid.each do |i|
      i.each do |j|
        if self[[i,j]].value == "K" && self[[i,j]].symbol == symbol
          enemy_team.each do |enemy|
            return true if Piece.moves(enemy).include?(self[[i,j]])
          end
        end
      end
    end
    false
  end

  def dup
  end

  def get_pieces(symbol)
    same_color = []
    @grid.each do |i|
      i.each do |j|
        if self[[i,j]].class != NullPiece && self[[i,j]].symbol == symbol
          same_color << self[[i,j]]
        end
      end
    end
    return same_color
  end

  def make_starting_grid
    whites = fill_white_pieces
    blacks = fill_black_pieces
    nulls = fill_null_pieces
    whites + nulls + blacks
  end

  def fill_black_pieces
    arr = []
    [6, 7].each do |i|
      row = []
      (0..7).each do |j|
        if i == 6
          row << Pawn.new([i, j], self, :b)
        else
          row << backline([i, j], :b)
        end
      end
      arr << row
    end
    arr
  end



  def fill_white_pieces
    arr = []
    [0, 1].each do |i|
      row = []
      (0..7).each do |j|
        if i == 1
          row << Pawn.new([i, j], self, :w)
        else
          row << backline([i, j], :w)
        end
      end
      arr << row
    end
    arr
  end

  def fill_null_pieces
    arr = []
    (2..5).to_a.each do |i|
      row = []
      (0..7).to_a.each do |j|
        # debugger
        row << NullPiece.instance
      end
      arr << row
    end
    arr
  end

  def backline(pos, symbol)
    j = pos[1]
    case j
    when 0, 7
      Rook.new(pos, self, symbol)
    when 1, 6
      Knight.new(pos, self, symbol)
    when 2, 5
      Bishop.new(pos, self, symbol)
    when 3
      King.new(pos, self, symbol)
    when 4
      Queen.new(pos, self, symbol)
    end
  end

end
