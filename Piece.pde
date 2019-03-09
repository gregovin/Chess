//a class for genaric pieces
class Piece{
  //each piece has a type, position, side, image, file path, number of moves made, and number of turns since last move
  public int type;
  public int coll;
  public int turnsSinceLast;
  public int row;
  public int side;
  public int moves_made;
  public String imgFilePath;
  public PImage img;
  //basic constructor
  public Piece(int type, int coll, int row, String imgFilePath, int side) {
    this(type, coll, row, imgFilePath, side, 0, side - 1);//make a piece
  }
  //advanced constructor
  public Piece(int type, int coll, int row, String imgFilePath,int side, int movesMade, int turnsSinceLast){
    //set all the variables to their counterparts
    this.type = type;
    this.coll = coll;
    this.row = row;
    this.moves_made = movesMade;
    this.side = side;
    this.turnsSinceLast = turnsSinceLast;
    this.imgFilePath= imgFilePath;
    //and load the image
    img = loadImage(imgFilePath);
  }
  //make a copy of this piece
  public Piece clone(){
    if(this instanceof Pawn){//if it's a pawn
      return new Pawn(side, imgFilePath, coll, row, moves_made, turnsSinceLast);//make a new pawn
    } else if(this instanceof Bishop){//if it's a bishop
      return new Bishop(side, imgFilePath, row, coll, moves_made, turnsSinceLast);//make a new bishop
    } else if(this instanceof King){//if it's a king
      return new King(side, imgFilePath, row, coll, moves_made, turnsSinceLast);//make it a king
    } else if(this instanceof Knight){//if it's a knight
      return new Knight(side, imgFilePath, row, coll, moves_made, turnsSinceLast);//make it a knight
    } else if(this instanceof Queen){//if it's a queen
      return new Queen(side, imgFilePath, row, coll, moves_made, turnsSinceLast);//make it a queen
    } else if(this instanceof Rook){//if it's a rook
      return new Rook(side, imgFilePath, row, coll, moves_made, turnsSinceLast);//make it a rook
    }
    return new Piece(this.type, this.coll, this.row, this.imgFilePath, this.side);//otherwise, make a piece
  }
  //returns a usefull string about this piece
  public String toString(){
    return "Piece: " + "(" + this.type + ", " + this.row + ", " + this.coll + ", " + this.side + ")";
  }
  //tells us weather this piece equals another one
  public boolean equals(Piece p){
    return this.type == p.type && this.coll == p.coll && this.row == p.row && this.side == p.side;
  }
  //draws the piece
  public void display(){
    image(img, (7 -coll) * 32 + SIDE_OFFSET, (7-row) * 32 + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT);
  }
  
  //provides a method to teleport the piece with no checks
  public void teleport(int newRow, int newColl){
    this.row = newRow;
    this.coll = newColl;
  }
  //a method to tell if a move is valid
  public boolean valid_move(int newRow, int newColl, Board board){
     return board.inBoard(newRow, newColl); 
  }
  //a method to move a piece and tell if it worked
  public boolean move(int newRow, int newColl, Board board) {
    if(this.valid_move(newRow, newColl, board)) {
      this.row = newRow;
      this.coll = newColl;
      moves_made ++;
      return true;
    }
    return false;
  }
  //a method to tell if a piece is in check(for kings)
  public int attacking(Board board){
    int a = 0;
    //look for pawns checking
    if(notNull(board.pieceAt(row + 1 - 2 * this.side, this.coll - 1)) &&
    board.pieceAt(row + 1 - 2 * this.side, this.coll - 1).type == 5 &&
    board.pieceAt(row + 1 - 2 * this.side, this.coll - 1).side == 1- side){
      a++;
    } 
    if(notNull(board.pieceAt(row + 1 - 2 * this.side, this.coll + 1))
    && board.pieceAt(row + 1 - 2 * this.side, this.coll + 1).type == 5
    && board.pieceAt(row + 1 - 2 * this.side, this.coll + 1).side == 1- side){
      a++;
    }
    //look for knights checking
    for(int x = 1; x < 3; x ++){
      for(int sig1 = -1; sig1 < 2; sig1 += 2){
        for(int sig2 = -1; sig2 < 2; sig2 += 2){
          if(notNull(board.pieceAt(row + x * sig1, coll + (3-x) * sig2)) && 
          board.pieceAt(row + x * sig1, coll + (3-x) * sig2).type == 3 && 
          board.pieceAt(row + x * sig1, coll + (3-x) * sig2).side == 1-this.side){
            a++;
          }
        }
      }
    }
    //look for bishops and queens
    int k = 1;
    while(!notNull(board.pieceAt(k + row, k+coll)) && board.inBoard(k + row, k + coll)){
       k++;
    }
    if(notNull(board.pieceAt(k + row, k+coll)) &&
    (board.pieceAt(k + row, k + coll).type == 4 || board.pieceAt(k + row, k + coll).type == 1) &&
    board.pieceAt(k + row, k + coll).side == 1- this.side){
      return a++;
    }
    k = -1;
    while(!notNull(board.pieceAt(k + row, k+coll)) && board.inBoard(k + row, k + coll)){
       k--;
    }
    if(notNull(board.pieceAt(k + row, k+coll)) &&
    (board.pieceAt(k + row, k + coll).type == 4 || board.pieceAt(k + row, k + coll).type == 1) &&
    board.pieceAt(k + row, k + coll).side == 1- this.side){
      return a++;
    }
    k = 1;
    while(!notNull(board.pieceAt(k + row, coll - k)) && board.inBoard(row + k, coll - k)){
       k++;
    }
    if(notNull(board.pieceAt(k + row, coll -k)) &&
    (board.pieceAt(k + row, coll -k).type == 4 || board.pieceAt(k + row, coll - k).type == 1) &&
    board.pieceAt(k + row,coll-k).side == 1- this.side){
      a++;
    }
    k = -1;
    while(!notNull(board.pieceAt(k + row, coll - k)) && board.inBoard(row + k, coll - k)){
       k--;
    }
    if(notNull(board.pieceAt(k + row, coll -k)) &&
    (board.pieceAt(k + row, coll -k).type == 4 || board.pieceAt(k + row, coll - k).type == 1) &&
    board.pieceAt(k + row,coll-k).side == 1- this.side){
      a++;
    }
    //looking for rooks and queens who are checking
    k = 1;
    while(!notNull(board.pieceAt(k + row, coll)) && board.inBoard(k + row, coll)){
       k++;
    }
    if(notNull(board.pieceAt(k + row, coll)) &&
    (board.pieceAt(k + row, coll).type == 2 || board.pieceAt(k + row, coll).type == 1) &&
    board.pieceAt(k + row, coll).side == 1- this.side){
      a++;
    }
    k = -1;
    while(!notNull(board.pieceAt(k + row, coll)) && board.inBoard(k + row, coll)){
       k--;
    }
    if(notNull(board.pieceAt(k + row, coll)) &&
    (board.pieceAt(k + row, coll).type == 2 || board.pieceAt(k + row, coll).type == 1) &&
    board.pieceAt(k + row, coll).side == 1- this.side){
      a++;
    }
    k = 1;
    while(!notNull(board.pieceAt(row, coll + k)) && board.inBoard(row, coll + k)){
       k++;
    }
    if(notNull(board.pieceAt(row, coll + k)) &&
    (board.pieceAt(row, coll + k).type == 2 || board.pieceAt(row, coll + k).type == 1) &&
    board.pieceAt(row,coll + k).side == 1- this.side){
      a++;
    }
    k = -1;
    while(!notNull(board.pieceAt(row, coll + k)) && board.inBoard(row, coll + k)){
       k--;
    }
    if(notNull(board.pieceAt(row, coll + k)) &&
    (board.pieceAt(row, coll + k).type == 4 || board.pieceAt(row, coll + k).type == 1) &&
    board.pieceAt(row,coll + k).side == 1- this.side){
      a++;
    }
    for(int x = -1; x <= 1; x++){
      for(int y = -1; y <=1; y++){
        if(notNull(board.pieceAt(row + x, coll+ y)) && board.pieceAt(row + x, coll+ y).type == 0 && board.pieceAt(row + x, coll+ y).side == 1- this.side){
          a++;
        }
      }
    }
    return a;
  }
  public boolean inCheck(Board board){
    return false;
  }
  //a method to update turnsSinceLast
  public void updateTurns(){
    if (moves_made != 0){
      turnsSinceLast ++;
    }
  }
}
