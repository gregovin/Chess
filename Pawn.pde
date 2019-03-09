//the pawn class
class Pawn extends Piece{
  //intialized contsructor
  public Pawn(int side, String imgFilePath, int coll) {
    super(5, coll, 5 * side + 1, imgFilePath, side);//puts the pawn in the right row
    
  }
  //arbitrary location constructor
  public Pawn(int side, String imgFilePath, int coll, int row){
    super(5, coll, row, imgFilePath, side);//puts the pawn in an arbitrary place
  }
  //general constructor
  public Pawn(int side, String imgFilePath, int coll, int row, int movesMade, int turnsSinceLast){
    super(5, coll, row, imgFilePath, side, movesMade, turnsSinceLast);//used to clone
  }
  //tells us if we can move there
  public boolean valid_move(int newRow, int newColl, Board board){
    if(newColl == coll){//if it is the same collumb
      if(newRow - row == 2 - 4 * side && this.moves_made == 0 && !notNull(board.pieceAt(row + 1 - 2 * side, newColl)) && !notNull(board.pieceAt(newRow, newColl))){
        //if it is 2 squares ahead and this has not made a move and there is nothing in the way
        movesSinceIrreversible = -1;//thats an irreversible
        return true;//we can
      }else if(newRow - row == 1 - 2 * side && !notNull(board.pieceAt(newRow, newColl))){//if it is one square ahead
      //and nothing is in the way
        if(newRow == 7 - 7 * side) promotes = true;//if we are going to the last row, we promote
        movesSinceIrreversible = -1;//thats an irreversible
        return true;//we can
      }
    } else if(Math.abs(newColl - coll) == 1 && newRow - row == 1 - 2 * side){//are we trying to capture
      if(notNull(board.pieceAt(newRow, newColl))){//is there a piece their
        if(newRow == 7 - 7 * side) promotes = true;//last row=promotes
        if(board.pieceAt(newRow, newColl).side == 1 - this.side){//if it is not on my team
            movesSinceIrreversible=-1;//thats an irreversible
            return true;//capture it
          } else return false;//we can't
      } else if(notNull(board.pieceAt(row, coll))){
        Piece test = board.pieceAt(row,newColl);
        if(test.type == this.type && test.moves_made == 1 && test.row == 3 + test.side && test.side == 1 - this.side
        && test.turnsSinceLast==0){
            movesSinceIrreversible=-1;
            empesa = true;
            return true;
          } else return false;
      }
    }
    return false;
  }
}
