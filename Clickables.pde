//initialize some variables to track the mouse position, where we clicked, and the second place we clicked
int mousex = -1;
int mousey = -1;
int clickedRow= -1;
int clickedCol = -1;
int clickedRow2 = -1;
int clickedCol2 = -1;
boolean is_chosing = true;//are we choosing the piece or where it goes
int GRID_X_MIN = SIDE_OFFSET;//the edges of the grid
int GRID_Y_MIN = TOP_OFFSET;
int GRID_X_MAX = GRID_X_MIN + SQUARE_WIDTH * 8;
int GRID_Y_MAX = GRID_Y_MIN + SQUARE_HEIGHT * 8;
void mousePressed(){
  //if we are in the grid and choosing
  if (is_chosing && between(mouseX, GRID_X_MIN, GRID_X_MAX) && between(mouseY, GRID_Y_MIN, GRID_Y_MAX)) {
    // Identify the cell using standard cords
    clickedRow = (mouseY-GRID_Y_MIN) / SQUARE_HEIGHT;
    clickedCol = (mouseX-GRID_X_MIN) / SQUARE_WIDTH;
    if(notNull(b.pieceAt(7-clickedRow, 7-clickedCol))){//if there is something there
      is_chosing = ! is_chosing;//we are now looking for were to move it
    }
  } else if(between(mouseX, GRID_X_MIN, GRID_X_MAX) && between(mouseY, GRID_Y_MIN, GRID_Y_MAX)){
    //if we are in the grid but not choosing
    //identify where we clicked
    clickedRow2 = (mouseY-GRID_Y_MIN) / SQUARE_HEIGHT;
    clickedCol2 = (mouseX-GRID_X_MIN) / SQUARE_WIDTH;
    is_chosing = ! is_chosing;//start choosing
    if(clickedRow != clickedRow2 || clickedCol != clickedCol2){//if we chose 2 different squares
      b.move(7-clickedRow, 7-clickedCol, 7-clickedRow2, 7-clickedCol2);//try to move the piece we chose to where it goes
    }
  } else if(between(mouseX, 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 11 * SQUARE_WIDTH + 2 * SIDE_OFFSET) && between(mouseY, 3 * SQUARE_HEIGHT + TOP_OFFSET, (7 * SQUARE_HEIGHT)/2 + TOP_OFFSET)){
    //if we clicked one of white's buttons
    //figure out which one
    int buttonClicked = (mouseX - 8 * SQUARE_WIDTH - 2 * SIDE_OFFSET)/SQUARE_WIDTH;
    if(turn == 0 && buttonClicked == 2){//if it's whites turn and they clicked the resign button
      gameOver = 2;//black wins
      reasonForGO = 1;//by resignation
    } else if(turn == 0 && buttonClicked == 1){//if it's whites turn and they clicked the draw offer button
      //ask if the other player accepts and get the result
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "White has offered a draw, do you accept", "Draw", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(JOptionPane.YES_OPTION)){//if the value is yes
         gameOver = 3;//it's a draw
         reasonForGO = 3;//by draw offer
      }
    } else if(buttonClicked == 0 && posLs.size() > 1){//if we clicked the takeback button
      //ask if black accepts and store the value
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "White has asked for a takeback, do you accept?", "takeback", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(JOptionPane.YES_OPTION)){
         b.setPos(posLs.get(posLs.size()-2));//set the board position to the previous position
         posLs.remove(posLs.size()-1);//remove this position from the list
         turn = 1 - turn;//reset the turn
      }
    }
  } else if(between(mouseX, 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 11 * SQUARE_WIDTH + 2 * SIDE_OFFSET) && between(mouseY, TOP_OFFSET + SQUARE_HEIGHT, (3 *SQUARE_HEIGHT)/2 + TOP_OFFSET)){
    //if one of black buttons is clicked
    //do mostly the same stuff but switch black and white
    int buttonClicked = (mouseX - 8 * SQUARE_WIDTH - 2 * SIDE_OFFSET)/SQUARE_WIDTH;
    if(turn == 1 && buttonClicked == 2){
      gameOver = 1;
      reasonForGO = 1;
    } else if(turn ==1 && buttonClicked == 1){
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "Black has offered a draw, do you accept", "Draw", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(0)){
         gameOver = 3;
         reasonForGO = 3;
      }
    } else if(buttonClicked == 0 && posLs.size() > 1){
      Object selectedValue = JOptionPane.showConfirmDialog(null,
        "Black has asked for a takeback, do you accept?", "takeback", JOptionPane.YES_NO_OPTION);
      if(selectedValue.equals(0)){
         b.setPos(posLs.get(posLs.size()-2));
         posLs.remove(posLs.size()-1);
         turn = 1-turn;
      }
    }
  }
  
}
