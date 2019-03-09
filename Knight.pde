//a knight class for knight's
class Knight extends Piece{
  //initial constructor
  public Knight(int side, String imgFilePath, int coll) {
    super(3, coll, 7 * side, imgFilePath, side);//puts the knight on the home row
  }
  //arbitrary locale constructor
  public Knight(int side, String imgFilePath, int row, int coll) {
    super(3, coll, row, imgFilePath, side);//puts the knight at an arbitrary location
  }
  //general constructor
  public Knight(int side, String imgFilePath, int row, int coll, int movesMade, int turnsSinceLast) {
    super(3, coll, row, imgFilePath, side, movesMade, turnsSinceLast);//used for cloning
  }
  //tells us if we can we make this move
  public boolean valid_move(int newRow, int newColl, Board board){
    if(Math.abs(newRow-row) == 2 && Math.abs(newColl-coll) ==1){//if it is 2 rows and one coll away
      if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){//if we can capture
        movesSinceIrreversible= -1;//thats an irreversible
        return true;//we can move there
      } else if(notNull(board.pieceAt(newRow, newColl))) return false;//there is a white piece there
      return true;//we can do it
    } else if(Math.abs(newRow-row) == 1 && Math.abs(newColl-coll) ==2){//if it is 1 row and 2 colls
    //much the same
      if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){
        movesSinceIrreversible= -1;
        return true;
      } else if(notNull(board.pieceAt(newRow, newColl))) return false;
      return true;
    }
    return false;
  }
}
