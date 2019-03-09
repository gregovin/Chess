class Position{
  private Piece[][] piecelist;
  public Position(Piece[][] piecelist){
    this.piecelist = piecelist;
  }
  public Position clone(){
    Piece[][] pls = new Piece[piecelist.length][piecelist[0].length];
    for(int i = 0;i < piecelist.length;i ++){
      for(int j = 0; j < piecelist[i].length; j++){
        if(notNull(piecelist[i][j])){
          pls[i][j] = piecelist[i][j].clone();
        } else {
          pls[i][j] =null;
        }
      }
    }
    return new Position(pls);
  }
  public Piece[] kings(){
    Piece[] res = new Piece[2];
    for(Piece[] pl : piecelist){
      for(Piece p : pl){
        if(notNull(p) && p.type == 0){
          res[p.side] = p;
        }
      }
    }
    return res;
  }
  public Piece pieceAt(int row, int coll){
    if(!b.inBoard(row, coll)){
      return null;
    }
    return piecelist[row][coll];
  }
  public Piece[][] getPiecelist(){return piecelist;}
  public void display(){
    for(Piece[] pl : piecelist){
      for(Piece p: pl){
        if(notNull(p)){
          p.display();
        }
      }
    }
  }
  public boolean equals(Position o){
    Piece[][] opls = o.getPiecelist();
    for(int i = 0;i < piecelist.length; i ++){
      for(int j = 0; j < piecelist[i].length; j ++){
        if(notNull(piecelist[i][j]) && notNull(opls[i][j])){
          if(!piecelist[i][j].equals(opls[i][j])){
            return false;
          }
        }else if( piecelist[i][j] != opls[i][j]){
          return false;
        }
      }
    }
    return true;
  }
  public void teleport(int currow, int curcol, int newrow, int newcol){
    Piece moving = piecelist[currow][curcol];
    if(notNull(moving) && b.inBoard(newrow, newcol)){
      moving.teleport(newrow, newcol);
      piecelist[currow][curcol] = null;
      piecelist[newrow][newcol] = moving;
    }
  }
  public boolean move(int currow, int curcol, int newrow, int newcol){
    Piece moving = piecelist[currow][curcol];
    if(notNull(moving) && b.inBoard(newrow, newcol) && moving.side == turn){
      moving.teleport(newrow, newcol);
      piecelist[currow][curcol] = null;
      Piece temp = piecelist[newrow][newcol];
      piecelist[newrow][newcol] = moving;
      if(kings()[moving.side].inCheck(b)){
        moving.teleport(currow, curcol);
        piecelist[currow][curcol] = moving;
        piecelist[newrow][newcol] = temp;
        return false;
      } else {
        moving.teleport(currow, curcol);
        piecelist[currow][curcol] = moving;
        piecelist[newrow][newcol] = temp;
        if(moving.move(newrow,newcol, b)){
          piecelist[newrow][newcol] = moving;
          piecelist[currow][curcol] = null;
          times[turn].stop();
          turn = 1 - turn;
          times[turn].start();
          if(empesa){
            piecelist[currow][newcol] = null;
            empesa = false;
          }
          if(promotes){
             Object selectedValue = JOptionPane.showInputDialog(null,
             "Promotes To", "Pieces",
             JOptionPane.INFORMATION_MESSAGE, null,
             possibleValues, possibleValues[0]);
            if(selectedValue.equals("Queen")){
              piecelist[newrow][newcol] = new Queen(moving.side, "img/" + sides[moving.side] + "Queen.png", newrow, newcol);
            } else if(selectedValue.equals("Knight")){
              piecelist[newrow][newcol] = new Knight(moving.side, "img/" + sides[moving.side] + "Knight.png", newrow, newcol);
            } else if(selectedValue.equals("Bishop")){
              piecelist[newrow][newcol] = new Bishop(moving.side, "img/" + sides[moving.side] + "Bishop.png", newrow, newcol);
            } else {
              piecelist[newrow][newcol] = new Rook(moving.side, "img/" + sides[moving.side] + "Rook.png", newrow, newcol);
            }
            promotes = false;
          }
          if(turn == 1){
            for(Piece[] pl : piecelist){
              for(Piece p: pl){
                if(notNull(p)) p.updateTurns();
              }
            }
          }
          return true;
        }
        return false;
      }
    }
    return false;
  }
}
