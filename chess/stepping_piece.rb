module SteppingPiece

  KNIGHT = [
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2],
    [-2, -1],
    [-2, 1],
    [2, -1],
    [2, 1]
  ]

  KING = [
    [1,1],
    [1,0],
    [1,-1],
    [0,1],
    [0,-1],
   [-1, 1],
   [-1,0],
   [-1,-1]
 ]

  def move_knight(pos)
   moves = []
   KNIGHT.each do |diff|
     x = pos[0] + diff[0]
     y = pos[1] + diff[1]
     moves << [x,y] if x.between?(0,7) && y.between?(0,7)
   end
   moves
  end

  def move_king(pos)
   moves = []
   KING.each do |diff|
     x = pos[0] + diff[0]
     y = pos[1] + diff[1]
     moves << [x,y] if x.between?(0,7) && y.between?(0,7)
   end
   moves
  end

  def legal_moves
    case self.class
    when King
      move_king(self.pos)
    when Knight
      move_knight(self.pos)
    end
  end


end
