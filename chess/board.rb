require_relative "piece"

class Board
  attr_reader :grid

  def initialize
    @grid = make_starting_grid
  end

  def move_piece(start_pos, end_pos)
      raise "empty square" if self[start_pos].symbol.nil?
      raise "cannot move there" unless self[start_pos].valid_move?(end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = Piece.new(start_pos)
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
        row << Piece.new([i, j], :b)
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
        row << Piece.new([i, j], :w)
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
        row << Piece.new([i, j])
      end
      arr << row
    end
    arr
  end

end
