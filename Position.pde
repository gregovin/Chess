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
