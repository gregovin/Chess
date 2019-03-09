class King extends Piece{
  //specific constructor, puts the king in the right starting location
  public King(int side, String imgFilePath) {
    super(0 , 3, 7 * side, imgFilePath, side);
  }
  //arbitrary location constructor, puts the king in an arbitrary position
  public King(int side, String imgFilePath, int row, int coll){
    super(0 , coll, row, imgFilePath, side);
  }
  //generic constructor, used for cloning the king
  public King(int side, String imgFilePath, int row, int coll, int movesMade, int turnsSinceLast){
    super(0 , coll, row, imgFilePath, side, movesMade, turnsSinceLast);
  }
  //check if it is a valid move
  public boolean valid_move(int newRow, int newColl, Board board){
    if(Math.abs(newRow - row) > 1 || Math.abs(newColl - coll) > 2){//if we are trying to go more than 1 row or 2 colls
       return false;//we can't
     } else if(newColl - coll == 2 && ! this.inCheck(board)){//if we are going 2 colls to the left and we arn't in check
       println("attempting to castle queenside");//print a diagonstic for my sanity
       Piece corner = board.pieceAt(7 * side, 7);//get the cornerpiece
       if(!notNull(corner) || corner.type != 2 || corner.moves_made !=0 || this.moves_made != 0 || 
           notNull(board.pieceAt(7 * side, 6)) || notNull(board.pieceAt(7 * side, 5)) || notNull(board.pieceAt(7 * side, 4)) || this.inCheck(board)){
              //if the corner piece is null or not a rook or has made a move
              //or we have made a move or is in check
              //or there are pieces in the way
              println("failed due to lack of neccesary conditions");//we failed to castle
              return false;
       }
       if(board.move(7 *side, 7, 7 * side, newColl-1)){//if we can move the rook where it needs to go
         board.teleport(7 * side, newColl-1, 7 * side, 7);//put it back
         undoMove();//undo the move
         if(board.move(this.row, this.coll, 7 * side, newColl-1)){//if we can move the king one square in the right direction
           undoMove();//undo the move, but keep the position and stuff
            if(board.move(this.row, this.coll, 7 * side, newColl)){//if we can move the king another square
               board.teleport(7 * side, 7, 7 * side, newColl-1);//teleport the rook to the right place
               println("casle succeded");//we did it
               undoMove();//undo move to keep the timer and stuff in sink
               return true;//yay
           }
         }
       }
       println("rook or king could not move");//something went wong
       this.moves_made =0;//reset
       corner.moves_made = 0;
       return false;//can't do it
     } else if(newColl - coll == -2){//if we are going to the right
       println("attempting to castle kingside");//system dialog for my sanity
       Piece corner = board.pieceAt(7 * side, 0);//get the corner piece
       if(!notNull(corner) || corner.type != 2 || corner.moves_made !=0 || this.moves_made != 0 ||
               notNull(board.pieceAt(7 * side, 1)) || notNull(board.pieceAt(7 * side, 2)) || this.inCheck(board)){
          //if there is no corner piece or it is not a rook or it has made a move
          //or this piece has made a move or is in check
          //or something is in the way
         return false;//we can't
       }
       if(board.move(7 * side, 0, 7 * side, newColl+1)){//can we move the rook to the right place?
         board.teleport(7*side, newColl+1, 7*side, 0);//put it back
         undoMove();//undo the move
         if(board.move(this.row, this.coll, 7*side, 2)){//if we can move the king one square
           undoMove();//make sure the timers and stuff are right
           if(board.move(this.row, this.coll, 7*side, newColl)){//can we move one more square?
             board.teleport(7*side, 0, 7*side, newColl+1);//teleport the rook
             undoMove();//sink the timers and stuff
             return true;//we did it
           }
         }
       }
       println("rook or king could not move");//something whent horribly wrong
       this.moves_made =0;//reset
       corner.moves_made = 0;
       return false;//nope
     }
     if(notNull(board.pieceAt(newRow, newColl)) && board.pieceAt(newRow, newColl).side == 1 - this.side){//if we can capture
       movesSinceIrreversible = -1;//we did an irreversible
       return true;//we can move
     } else if(notNull(board.pieceAt(newRow, newColl))) return false;//there is a piece their of my color, nope
     return true;//we can do it
  }
  //seeing if we are in check
  public boolean inCheck(Board board){
    return this.attacking(board)>0;//are we attacked by atleast one piece?
  }
}
