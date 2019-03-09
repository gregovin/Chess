Board b; //get a board
public int gameOver = 0; //stores if game is over
// 0 is ongoing, 1 is white wins, 2 is black wins, 3 is draw
public int reasonForGO = 0; //stores reason for game over
public String[] reasons = {"Check mate", "resignation", "Time out", "Draw Offer", "Three fold repitition", 
"Perpetual", "50 move rule", "Insuficient material"}; //list of reasons for game over
//0 is check mate, 1 is resign, 2 is time out, 3 is draw offer, 4 is three fold, 5 is perpetual, 6 is 50 move rule, 7 is insuficient material
final int INITIAL_TIME = 10; //how much time you start with
final int INC = 10; //the increment
final int SQUARE_WIDTH = 32; //width of the squares
final int SQUARE_HEIGHT = 32; //height of the squares
String[] sides = {"white", "black"};//the names of the sides
final int SIDE_OFFSET = 10;//offset between side of the window and side of the board
final int TOP_OFFSET = 10; //offset between top of the window and top of the board
Timer[] times; //list of timers
boolean empesa = false; //weather an empesa happened this turn
boolean promotes = false; //weather a promotion happened
String[] possibleValues = {"Bishop", "Knight", "Rook", "Queen"}; //possible promotion values
int turn = 0;//whose turn it is
final int BUTTON_WIDTH = 100; //width of each button
final int BUTTON_HEIGHT = 40; //hieght of each button
public int movesSinceIrreversible = 0; //moves since the last irreversible move
ArrayList<Position> posLs = new ArrayList<Position>(); //a list of all the positions

//a method that clears up the stuf so things that use the move meathod don't affect the timers and stuff
public void undoMove(){
  times[1-turn].unStop(); //restart the timer
  turn = 1 - turn; //set the turn
  posLs.remove(posLs.size() -1); //get rid of the last position
  movesSinceIrreversible --; //remove one non-irreversible move
  gameOver = 0;//the game is not over
}

//a method to check if a three fold repition has occured
public void checkThreeFold(){
  Position cur = posLs.get(posLs.size()-1);//get the current pos
  int count = 1;//start count at one
  
  //for every position since the last irreversible to the one before this one
  for(int i =posLs.size()-movesSinceIrreversible - 1; i < posLs.size()-1 && count < 3; i ++){
    if(cur.equals(posLs.get(i))) { //if it is the same position
      count++;//incrament count
    }
  }
  if(count >= 3){ //if there are 3 repeats
    gameOver = 3; //its a draw
    reasonForGO = 4;//by three fold rep
  }
}

//method for checking if a is between lower and upper
public static boolean between(int a, int lower, int upper) {
  return (a >= lower) && (a <= upper);
}
//method to check if a piece is not null
public static boolean notNull(Piece piece) {
    if (piece == null) {
      return false;
    }
    return true;
}

//setup(called to initialize)
void setup(){
  size(512,512,P3D);//set the window up
  b = new Board();//initialize the board
  times = new Timer[2];//initialize the list of timers
  times[0] = new Timer(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 2 * SQUARE_HEIGHT + TOP_OFFSET, INITIAL_TIME, INC, 0);//make white's timer
  times[1] = new Timer(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, TOP_OFFSET, INITIAL_TIME,INC, 1);//make black's timer
  times[0].start();//start whites timer
  frameRate(30);//set the framerate to 30fps
}

//draw(called every 1/30 of a second)
void draw(){
  background(#db9732);//set the backgrount
  fill(#ffffff);//set the fill to white
  rect(SIDE_OFFSET, TOP_OFFSET, 8 *SQUARE_WIDTH, 8 * SQUARE_HEIGHT);//make a rectangle the size of the game board
  fill(#323232);//set the fill to gray
  for(int i = 0; i < 8; i ++){//add the grey squares
    for(int j = i % 2; j < 8; j += 2){
      rect(j * SQUARE_WIDTH + SIDE_OFFSET, i * SQUARE_HEIGHT+TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT);
    }
  }
  b.getPos().display();//display the position
  
  times[0].display();//display the timers
  times[1].display();
  if(gameOver==0){//tick each timer if the game is on
    times[0].tickOne(1.0/30);
    times[1].tickOne(1.0/30);
  } else {
    fill(#000000);
    rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 4 * SQUARE_HEIGHT + TOP_OFFSET, 4 * SQUARE_WIDTH, 2 * SQUARE_HEIGHT);//make a square for text
    fill(#ffffff);
    textAlign(CENTER, CENTER);//align to center
    if(gameOver < 3){//if it is not a draw
      //put the reason on one line
      text(reasons[reasonForGO], 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + SQUARE_HEIGHT/2);
      //followed by who won
      text(sides[gameOver-1] + " won", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + 3 * SQUARE_HEIGHT/2);
    } else {//otherwise
      //put the reason on one line
      text(reasons[reasonForGO], 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + SQUARE_HEIGHT);
      //followed by draw
      text("draw", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + 2 * SQUARE_WIDTH, 4 * SQUARE_HEIGHT + TOP_OFFSET + 3 * SQUARE_HEIGHT/2);
    }
  }
  if(movesSinceIrreversible >= 100) {//if there have been >= 50 moves since the last irreversible
    gameOver = 3;//its a draw
    reasonForGO = 6;//by 50 move rule
  }
  drawButtons();//draw the buttons
}

//draws the buttons
void drawButtons(){
  //put some borders on the images
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  //draws the resign images
  image(loadImage("img/Resign.png"), 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  image(loadImage("img/Resign.png"), 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH * 2, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  fill(#f2f2f2);//set the fill
  //draw the rects for the other buttons
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + SQUARE_WIDTH, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, 3 * SQUARE_HEIGHT + TOP_OFFSET, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  rect(8 * SQUARE_WIDTH + 2 * SIDE_OFFSET, TOP_OFFSET + SQUARE_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT/2);
  textAlign(CENTER, CENTER);
  fill(#000000);
  //put the button text on them
  text("1/2", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (3 *SQUARE_WIDTH)/2, (13 * SQUARE_HEIGHT/4) + TOP_OFFSET);
  text("1/2", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (3 *SQUARE_WIDTH)/2, (5 * SQUARE_HEIGHT/4) + TOP_OFFSET);
  text("TB", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (SQUARE_WIDTH)/2, (13 * SQUARE_HEIGHT/4) + TOP_OFFSET);
  text("TB", 8 * SQUARE_WIDTH + 2 * SIDE_OFFSET + (SQUARE_WIDTH)/2, (5 * SQUARE_HEIGHT/4) + TOP_OFFSET);
}
