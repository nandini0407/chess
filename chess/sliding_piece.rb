module SlidingPiece

  HV = [ [1,0], [-1,0], [0,1], [0,-1]]
  DIAGONAL = [[-1,1], [-1,-1], [1,1], [1,-1]]

  def move_dir(dir, pos)
    if dir == :diagonal
      moves = move_diagonal(pos)
    elsif dir == :hv
      moves = move_hv(pos)
    elsif dir == :both
      moves = move_diagonal(pos) + move_hv(pos)
    end
    moves
  end

  def move_diagonal(pos)
    moves = []
    DIAGONAL.each do |diff|
      x = pos[0] + diff[0]
      y = pos[1] + diff[1]
      moves << [x,y] if x.between?(0,7) && y.between?(0,7)
    end
    moves
  end

  def move_hv(pos)
    moves = []
    HV.each do |diff|
      x = pos[0] + diff[0]
      y = pos[1] + diff[1]
      moves << [x,y] if x.between?(0,7) && y.between?(0,7)
    end
    moves
  end


  def legal_moves
    possible_moves = move_dir(self.dir, self.pos)
    possible_moves.select { |move| valid_move?(move) }
    @all_legal_moves = possible_moves.dup
    possible_moves.each do |move|
      dx = move[0] - pos[0]
      dy = move[1] - pos[1]
      next_move = [move[0] + dx, move[1] + dy]
      while true
        if @board[next_move].class != NullPiece
          if @board[next_move].symbol == self.symbol
            @all_legal_moves << self.pos
            break
          elsif @board[next_move].symbol != self.symbol
            all_legal_moves << next_move
            break
          end
        else
          @all_legal_moves << next_move
          next_move = [next_move[0] + dx, next_move[1] + dy]
        end
      end
      @all_legal_moves
    end
  end

end
