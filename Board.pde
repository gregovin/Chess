import javax.swing.JOptionPane;//imports the thingy
//a chess board class
public class Board{
  public Position p;//the positon
  //get the piece at row, coll
  public Piece pieceAt(int row, int coll){
    return p.pieceAt(row, coll);
  }
  //set the position to a new position
  public void setPos(Position newPos){
    p = newPos;
  }
  //get a list of the pieces
  public Piece[][] pieceList(){return p.getPiecelist();}
  //get a list of the kings
  public Piece[] kings(){
    return p.kings();
  }
  //get the position
  public Position getPos(){return p;}
  //check if it is in the board
  public boolean inBoard(int row, int coll){
    return row >= 0 && row <= 7 && coll >= 0 && coll <= 7;
  }
  //teleport the piece at currow, curcol to newrow, newcol
  public void teleport(int currow, int curcol, int newrow, int newcol){
    p.teleport(currow, curcol, newrow, newcol);
  }
  //move the piece at currow, curcol to newrow, newcol if possible and return weather it worked
  public boolean move(int currow, int curcol, int newrow, int newcol){
    boolean success = p.move(currow, curcol, newrow, newcol);//did it work
    if(success){ 
      posLs.add(p.clone());//add a clone of the position to the array of positions
      movesSinceIrreversible ++;//we just did an irreversible
      checkThreeFold();//check for a draw
    }
    return success;//return weather it worked
  }
  //make a new board
  public Board(){
    Piece[][] piecelist = new Piece[8][8];//make a 2D 8X8 array of pieces
    //initialize each piece to the correct starting position
    piecelist[0][0] = new Rook(0, "img/whiteRook.png", 0);
    piecelist[0][7] = new Rook(0, "img/whiteRook.png", 7);
    piecelist[7][0] = new Rook(1, "img/blackRook.png", 0);
    piecelist[7][7] = new Rook(1, "img/blackRook.png", 7);
    piecelist[0][1] = new Knight(0, "img/whiteKnight.png", 1);
    piecelist[0][6] = new Knight(0, "img/whiteKnight.png", 6);
    piecelist[7][1] = new Knight(1, "img/blackKnight.png", 1);
    piecelist[7][6] = new Knight(1, "img/blackKnight.png", 6);
    piecelist[0][2] = new Bishop(0, "img/whiteBishop.png", 2);
    piecelist[0][5] = new Bishop(0, "img/whiteBishop.png", 5);
    piecelist[7][2] = new Bishop(1, "img/blackBishop.png", 2);
    piecelist[7][5] = new Bishop(1, "img/blackBishop.png", 5);
    piecelist[0][3] = new King(0, "img/whiteKing.png");
    piecelist[7][3] = new King(1, "img/blackKing.png");
    piecelist[0][4] = new Queen(0, "img/whiteQueen.png");
    piecelist[7][4] = new Queen(1, "img/blackQueen.png");
    //initialize the pawns
    for(int i = 0; i < 8; i++) {
      piecelist[1][i] = new Pawn(0, "img/whitePawn.png", i);
      piecelist[6][i] = new Pawn(1, "img/blackPawn.png", i);
    }
    //set the position to a new position given the list
    p = new Position(piecelist);
    posLs.add(p.clone());//add a clone of this to the list of positions
  }
}
