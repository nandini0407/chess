require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_reader :board

  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
    @board = board
  end

  def render
    puts "   0  1  2  3  4  5  6  7"
    (0..7).each do |i|
      print "#{i}  "
      (0..7).each do |j|
        if @cursor.cursor_pos == [i, j]
          # print "current".colorize(:color => :blue, :background => :green)
          if @board[[i,j]].class == NullPiece
            print " #{@board[[i,j]].symbol} ".colorize(:background => :yellow)
          elsif @board[[i, j]].symbol == :w
            print " #{@board[[i, j]].value} ".colorize(:color => :white, :background => :yellow)
          elsif @board[[i, j]].symbol == :b
            print " #{@board[[i, j]].value} ".colorize(:color => :black, :background => :yellow)
          end
        elsif (i + j).even?
          # print "in even".colorize(:color => :blue, :background => :green)
          if @board[[i,j]].class == NullPiece
            print " #{@board[[i,j]].symbol} ".colorize(:background => :green)
          elsif @board[[i, j]].symbol == :w
            print " #{@board[[i, j]].value} ".colorize(:color => :white, :background => :green)
          elsif @board[[i, j]].symbol == :b
            print " #{@board[[i, j]].value} ".colorize(:color => :black, :background => :green)
          end
        elsif (i + j).odd?
          # print "in odd".colorize(:color => :blue, :background => :green)
          if @board[[i,j]].class == NullPiece
            print " #{@board[[i,j]].symbol} ".colorize(:background => :light_blue)
          elsif @board[[i, j]].symbol == :w
            print " #{@board[[i, j]].value} ".colorize(:color => :white, :background => :light_blue)
          elsif @board[[i, j]].symbol == :b
            print " #{@board[[i, j]].value} ".colorize(:color => :black, :background => :light_blue)
          end
        end
      end
      print "\n"
    end
  end

  def move_around
    while true
      render
       @cursor.get_input
      # puts "Select piece to move (with space bar)"
    #   start_pos = @cursor.cursor_pos
    #   # puts "Select end position of the piece (with return)"
    #   end_pos = @cursor.get_input
    #   @board.move_piece(start_pos, end_pos, @board[start_pos])
    # end
  end

end
