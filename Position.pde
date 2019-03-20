//a position class list
class Position{
  private Piece[][] piecelist;//a list a the pieces
  public Position(Piece[][] piecelist){//Make a new position
    this.piecelist = piecelist;
  }
  public Position clone(){//clone this position
    Piece[][] pls = new Piece[piecelist.length][piecelist[0].length];
    for(int i = 0;i < piecelist.length;i ++){
      for(int j = 0; j < piecelist[i].length; j++){
        if(notNull(piecelist[i][j])){//if not null
          pls[i][j] = piecelist[i][j].clone();//clone the piece
        } else {//otherwise
          pls[i][j] =null;//set to null
        }
      }
    }
    return new Position(pls);//return the new position
  }
  public Piece[] kings(){//get a list of kings
    Piece[] res = new Piece[2];//make a list of 2 pieces
    for(Piece[] pl : piecelist){//loop through the list
      for(Piece p : pl){
        if(notNull(p) && p.type == 0){//if it is a king
          res[p.side] = p;//set one of the elements to the king
        }
      }
    }
    return res;//return the list
  }
  public Piece pieceAt(int row, int coll){//get a piece at this position
    if(!b.inBoard(row, coll)){
      return null;
    }
    return piecelist[row][coll];
  }
  public Piece[][] getPiecelist(){return piecelist;}//return the piece list
  public void display(){//display it
    for(Piece[] pl : piecelist){//loop through the elements
      for(Piece p: pl){
        if(notNull(p)){//if there is a piece
          p.display();//display it
        }
      }
    }
  }
  public boolean equals(Position o){//is this position equal to another one
    Piece[][] opls = o.getPiecelist();//set a list to the other position's piecelist
    for(int i = 0;i < piecelist.length; i ++){//for all the positions
      for(int j = 0; j < piecelist[i].length; j ++){
        if(notNull(piecelist[i][j]) && notNull(opls[i][j])){
          //if there are pieces in both positions at the same place
          if(!piecelist[i][j].equals(opls[i][j])){//if they aren't the same
            return false;//they are not equal
          }
        }else if( piecelist[i][j] != opls[i][j]){//if they are not equal(ie only one is null)
          return false;//they are not equal
        }
      }
    }
    return true;//they are equal
  }
  public int[] checkGameOver(int side){
    King k = (King) this.kings()[side];
    int[] go = {0, 0};
    if(k.attacking(b) > 1){
      boolean canMove = false;
      for(int i = -1; i < 2 && !canMove; i ++){
        for(int j = -1; j < 2 && !canMove; j ++){
          if(i==j && j==0){
            
          }else if(!notNull(pieceAt(i + k.row, j + k.coll))){
            Piece p = new Piece(-1, j+k.coll, i + k.row, "img/Resign.png", side);
            piecelist[i + k.row][j+ k.coll] = p;
            if(p.attacking(b) == 0){
              canMove = true;
            }
            piecelist[i+k.row][j+k.coll] = null;
          }
        }
      }
      if(!canMove){
        go[0] = 2-side;
        go[1] = 0;
      }
    } else if(k.attacking(b) == 1){
      boolean canMove = false;
      for(int i = -1; i < 2 && !canMove; i ++){
        for(int j = -1; j < 2 && !canMove; j ++){
          if(i==j && j==0){
            
          }else if(b.inBoard(i + k.row, j + k.coll) && !notNull(pieceAt(i + k.row, j + k.coll))){
            Piece p = new Piece(-1, j+k.coll, i + k.row, "img/Resign.png", side);
            piecelist[i + k.row][j+ k.coll] = p;
            if(p.attacking(b) == 0){
              canMove = true;
            }
            piecelist[i+k.row][j+k.coll] = null;
          }
        }
      }
      if(!canMove){
         Piece a = k.attackingPieces(b).get(0);
         println(a.type);
         boolean canBlock = false;
         if(a.attacking(b) > 0){
           ArrayList<Piece> attackers = a.attackingPieces(b);
           for(int i = 0; i < attackers.size() && !canBlock; i ++){
             Piece temp = attackers.get(i).clone();
             if(b.move(attackers.get(i).row, attackers.get(i).coll, p.row, p.coll)){
               piecelist[a.row][a.coll] = a;
               piecelist[temp.row][temp.coll] = temp;
               undoMove();
               canBlock = true;
             }
           }
         }
         if(!canBlock && (a.type == 3 || a.type == 5)){
           go[0] = 2 - side;
           go[1] = 0;
         } else if(!canBlock && a.coll == k.coll && (a.type==1 || a.type==2)){
           int add = sign(a.row-k.row);
           int d = add;
           while(d<a.row-k.row && !canBlock){
             Piece p = new Piece(-1, k.coll, d + k.row, "img/Resign.png", 1-side);
             piecelist[d+k.row][k.coll] = p;
             if(p.attacking(b) >0){
               ArrayList<Piece> attackers = p.attackingPieces(b);
               for(int i = 0; i < attackers.size() && !canBlock; i ++){
                 Piece temp = attackers.get(i).clone();
                 if(b.move(attackers.get(i).row, attackers.get(i).coll, p.row, p.coll)){
                   piecelist[p.row][p.coll] = null;
                   piecelist[temp.row][temp.coll] = temp;
                   undoMove();
                   canBlock = true;
                 } else piecelist[p.row][p.coll] = null;
               }
             }
             d += add;
           }
         } else if(!canBlock && a.row == k.row && (a.type==1 || a.type==2)){
           int add = sign(a.coll-k.coll);
           int d = add;
           while(d<a.coll-k.coll && !canBlock){
             Piece p = new Piece(-1,d+k.coll, k.row, "img/Resign.png", 1-side);
             piecelist[k.row][d+k.coll] = p;
             if(p.attacking(b) >0){
               ArrayList<Piece> attackers = p.attackingPieces(b);
               for(int i = 0; i < attackers.size() && !canBlock; i ++){
                 Piece temp = attackers.get(i).clone();
                 if(b.move(attackers.get(i).row, attackers.get(i).coll, p.row, p.coll)){
                   piecelist[p.row][p.coll] = null;
                   piecelist[temp.row][temp.coll] = temp;
                   undoMove();
                   canBlock = true;
                 } else piecelist[p.row][p.coll] = null;
               }
             }
             d += add;
           }
         } else if(!canBlock && a.row-k.row==a.coll-k.coll && (a.type == 1 || a.type == 4)){
           int add = sign(a.coll-k.coll);
           int d = add;
           while(d<a.coll-k.coll && !canBlock){
             Piece p = new Piece(-1,d+k.coll, d+k.row, "img/Resign.png", 1-side);
             piecelist[d+k.row][d+k.coll] = p;
             if(p.attacking(b) >0){
               ArrayList<Piece> attackers = p.attackingPieces(b);
               for(int i = 0; i < attackers.size() && !canBlock; i ++){
                 Piece temp = attackers.get(i).clone();
                 if(b.move(attackers.get(i).row, attackers.get(i).coll, p.row, p.coll)){
                   piecelist[p.row][p.coll] = null;
                   piecelist[temp.row][temp.coll] = temp;
                   undoMove();
                   canBlock = true;
                 } else piecelist[p.row][p.coll] = null;
               }
             }
             d += add;
           }
         } else if(!canBlock && a.row-k.row==k.coll-a.coll && (a.type == 1 || a.type == 4)){
           println("Diagonal 2");
           int add = sign(a.row-k.row);
           int d = add;
           while(d<a.coll-k.coll && !canBlock){
             Piece p = new Piece(-1,k.coll-d, k.row+d, "img/Resign.png", 1-side);
             piecelist[k.row+d][k.coll-d] = p;
             if(p.attacking(b) >0){
               ArrayList<Piece> attackers = p.attackingPieces(b);
               for(int i = 0; i < attackers.size() && !canBlock; i ++){
                 Piece temp = attackers.get(i).clone();
                 if(b.move(attackers.get(i).row, attackers.get(i).coll, p.row, p.coll)){
                   piecelist[p.row][p.coll] = null;
                   piecelist[temp.row][temp.coll] = temp;
                   undoMove();
                   canBlock = true;
                 } else piecelist[p.row][p.coll] = null;
               }
             }
             d += add;
           }
         } else if(!canBlock){
           go[0] = 2 - side;
           go[1] = 0;
         }
      }
    }
    return go;
  }
  public void teleport(int currow, int curcol, int newrow, int newcol){//teleport from currow, curcol and newrow, necol
    Piece moving = piecelist[currow][curcol];
    if(notNull(moving) && b.inBoard(newrow, newcol)){//make sure there is a piece their
      moving.teleport(newrow, newcol);
      piecelist[currow][curcol] = null;
      piecelist[newrow][newcol] = moving;
    }
  }
  //move from currow, curcol and newrow, newcol and returns true if it worked
  public boolean move(int currow, int curcol, int newrow, int newcol){
    Piece moving = piecelist[currow][curcol];
    if(notNull(moving) && b.inBoard(newrow, newcol) && moving.side == turn){//make sure it is our turn and their is a piece
      moving.teleport(newrow, newcol);//make sure you can move it without putting the king in check
      piecelist[currow][curcol] = null;
      Piece temp = piecelist[newrow][newcol];
      piecelist[newrow][newcol] = moving;
      if(kings()[moving.side].inCheck(b)){
        moving.teleport(currow, curcol);//undo
        piecelist[currow][curcol] = moving;
        piecelist[newrow][newcol] = temp;
        return false;//you can't do it
      } else {
        moving.teleport(currow, curcol);//undo it
        piecelist[currow][curcol] = moving;
        piecelist[newrow][newcol] = temp;
        if(moving.move(newrow,newcol, b)){//if you can move
          piecelist[newrow][newcol] = moving;//do it
          piecelist[currow][curcol] = null;
          times[turn].stop();//stop the timer
          turn = 1 - turn;//switch the turns
          times[turn].start();//start the other timer
          if(empesa){//if we are empesaing
            piecelist[currow][newcol] = null;//set the correct piece to null
            empesa = false;//we are not empesaing
          }
          if(promotes){//if we are promoting
          //ask the user what piece they want to promote to and store the result
             Object selectedValue = JOptionPane.showInputDialog(null,
             "Promotes To", "Pieces",
             JOptionPane.INFORMATION_MESSAGE, null,
             possibleValues, possibleValues[0]);
            if(selectedValue.equals("Queen")){//if it is a queen, get a new queen into the game
              piecelist[newrow][newcol] = new Queen(moving.side, "img/" + sides[moving.side] + "Queen.png", newrow, newcol);
            } else if(selectedValue.equals("Knight")){//if it is a knight, get a new knight into the game
              piecelist[newrow][newcol] = new Knight(moving.side, "img/" + sides[moving.side] + "Knight.png", newrow, newcol);
            } else if(selectedValue.equals("Bishop")){//if it is a bishop, get a new bishop into the game
              piecelist[newrow][newcol] = new Bishop(moving.side, "img/" + sides[moving.side] + "Bishop.png", newrow, newcol);
            } else {//otherwise, it is a rook.
              piecelist[newrow][newcol] = new Rook(moving.side, "img/" + sides[moving.side] + "Rook.png", newrow, newcol);
            }
            promotes = false;//we are done promoting
          }
          if(turn == 1){//every other move
            for(Piece[] pl : piecelist){
              for(Piece p: pl){
                if(notNull(p)) p.updateTurns();//update the turns since last value
              }
            }
          }
          return true;//we did it
        }
        return false;//nope :(
      }
    }
    return false;//more nope :(
  }
}
