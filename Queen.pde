//a queen class
class Queen extends Piece{
  //starting constructor
  public Queen(int side, String imgFilePath) {//makes a queen in the starting position
    super(1, 4, 7 * side, imgFilePath, side);
  }
  //arbitrary location constructor
  public Queen(int side, String imgFilePath, int row, int coll){//makes a queen in any position
    super(1, coll, row, imgFilePath, side);
  }
  //generic constructor
  public Queen(int side, String imgFilePath, int row, int coll, int movesMade, int turnsSinceLast){//makes a queen exactly as told
    super(1, coll, row, imgFilePath, side, movesMade, turnsSinceLast);
  }
  //tells us weather this piece can move
  public boolean valid_move(int newRow, int newColl, Board board){
    //copy of rook code
    if(newRow == row){
      if(newColl > coll){
        int k = 1;
        while(k < newColl-coll && !notNull(board.pieceAt(row, coll+ k))){
          k++;
        }
        if(k == newColl-coll){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      } else if(newColl < coll){
        int k = -1;
        while(k > newColl-coll && !notNull(board.pieceAt(row, coll+ k))){
          k--;
        }
        if(k == newColl-coll){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      }
    } else if(newColl == coll){
      if(newRow > row){
        int k = 1;
        while(k < newRow-row && !notNull(board.pieceAt(row+k, coll))){
          k++;
        }
        if(k == newRow-row){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      } else if(newRow < row){
        int k = -1;
        while(k > newRow-row && !notNull(board.pieceAt(row + k, coll))){
          k--;
        }
        if(k == newRow-row){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      }
    } else if(newRow -row == newColl - coll){ //and here is the bishop code
      if(newRow > row){
        int k = 1;
        while(k<newRow-row && !notNull(board.pieceAt(k + row, k+coll))){
          k++;
        }
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      } else if(newRow < row){
        int k = -1;
        while(k>newRow-row && !notNull(board.pieceAt(k + row, k+coll))){
          k--;
        }
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      }
    } else if (newRow-row == coll - newColl){
      if(newRow > row){
        int k = 1;
        while(k<newRow-row && !notNull(board.pieceAt(k + row, coll - k))){
          k++;
        }
        println(row + k, coll - k);
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      } else if(newRow < row){
        int k = -1;
        while(k>newRow-row && !notNull(board.pieceAt(k + row, coll - k))){
          k--;
        }
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      }
    }
    return false;//we done
  }
}
