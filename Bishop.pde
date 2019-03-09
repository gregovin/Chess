//a bishop class
class Bishop extends Piece{
  //basic constructor
  public Bishop(int side, String imgFilePath, int coll) {
    super(4, coll, 7 * side, imgFilePath, side);//make a new pice on the home row with type 4 and the right data
  }
  //any location constructor
  public Bishop(int side, String imgFilePath, int row, int coll) {
    super(4, coll, row, imgFilePath, side);//make a new piece on any row
  }
  //genaric constructor
  public Bishop(int side, String imgFilePath, int row, int coll, int movesMade, int turnsSinceLast) {
    super(4, coll, row, imgFilePath, side, movesMade, turnsSinceLast);//make a piece with exact peramiters
  }
  
  //is this a legal move
  public boolean valid_move(int newRow, int newColl, Board board){
    if(newRow -row == newColl - coll){//if it is on one type of diagonal
      if(newRow > row){//if it going forward
        int k = 1;//start one ahead
        while(k<newRow-row && !notNull(board.pieceAt(k + row, k+coll))){//while we are between here and the location
        //and there is nothing in the way
          k++;//incrament
        }
        if(k == newRow - row){//if we made it
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){//if we can capture
            movesSinceIrreversible=-1;//irreversible just happened
            return true;//we can
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;//we can't, their is something in the way
          return true;//we can
        }
      } else if(newRow < row){//if it is going backward
        //do the last stuff but go backward
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
    } else if (newRow-row == coll - newColl){//if we are on the other diagonal
      if(newRow > row){//if we are going forward
        //check the diagonal forward
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
      } else if(newRow < row){ //if we are going backward
        //check the diagonal backward
        int k = -1;/
        while(k>newRow-row && !notNull(board.pieceAt(k + row, coll - k))){
          k--;
        }
        if(k == newRow - row){
          if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
            movesSinceIrreversible= -1;
            return true;
          } else if(notNull(board.pieceAt(newRow, newColl))) return false;
          return true;
        }
      }
    }
    return false;//not a place we can go to
  }
}
