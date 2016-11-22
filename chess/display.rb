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
    puts "   0   1   2   3   4   5   6   7"
    (0..7).each  do |i|
      print "#{i}  "
      (0..7).each do |j|
        if @cursor.cursor_pos == [i, j] && @board[[i, j]].symbol == :w
          print "#{ } ".colorize(:color => :white, :background => :yellow)
        elsif @cursor.cursor_pos == [i, j] && @board[[i, j]].symbol == :b
          print "#{ } ".colorize(:color => :black, :background => :yellow)
        elsif @board[[i, j]].symbol == :w
          print "#{ } ".colorize(:color => :white, :background => :brown)
        elsif @board[[i, j]].symbol == :b
          print "#{ } ".colorize(:color => :black, :background => :red)
        end
      end
      print "\n\n"
    end
  end

  def move_around
    while true
      render
      @cursor.get_input
    end
  end

end
