// a rook class
class Rook extends Piece {
  public Rook(int side, String imgFilePath, int coll) {//initial constructor, puts the rook on the home row
    super(2, coll, 7 * side, imgFilePath, side);
  }
  //arbitrary locale constructor, puts the rook wherever
  public Rook(int side, String imgFilePath, int row, int coll) {
    super(2, coll, row, imgFilePath, side);
  }
  //genaric constructor, allows complete customization
  public Rook(int side, String imgFilePath, int row, int coll, int movesMade, int turnsSinceLast) {
    super(2, coll, row, imgFilePath, side, movesMade, turnsSinceLast);
  }
  //tells us weather this piece can move there
  public boolean valid_move(int newRow, int newColl, Board board){
    if(newRow == row){//if it is the same row
      if(newColl > coll){//if we are going left
        int k = 1;//look for any pieces in the way
        while(k < newColl-coll && !notNull(board.pieceAt(row, coll+ k))){
          k++;
        }
        if(k == newColl-coll){//if there were none
          //if we are trying to capture and we can
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible=-1;//thats irreversible
            return true;//move
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;//actualy, we can't capture
          return true;//we can move there
        }
      } else if(newColl < coll){//if we are going right
        int k = -1;//same as last one
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
    } else if(newColl == coll){//if we stay in the same coll
      if(newRow > row){//much the same as for the rows
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
    }
    return false;//not a valid move
  }
}
