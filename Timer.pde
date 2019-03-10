//a timer class for timing
class Timer{
  //stores the number of minutes and seconds
  //stores an increment and a side
  //stores a position
  //keeps track of weather it is going
  private int minutes;
  private double seconds;
  private int inc;
  private boolean running;
  private int x;
  private int y;
  private int s;
  public Timer(int x, int y, int side){//standard constructor for a pos and a side
    minutes = 15;//sets the time control to 15 | 15
    seconds = 0;
    this.x = x;
    this.y = y;
    inc = 15;
    running = false;
    s = side;
  }
  public Timer(int x, int y, int min, int inc, int side){//arbitrary time control constructor, allows for more customization
    minutes = min;
    seconds = 0;
    this.inc = inc;
    running = false;
    this.x = x;
    this.y = y;
    s = side;
  }
  public void start(){//starts the timer
    running = true;//sets itself to be running
  }
  public void stop(){//stops the timer
    running = false;//stops itself from running
    //do the incrament
    if(seconds >= 60 - inc){//if we will overflow
      seconds -= 60;//decrease seconds by 60
      minutes ++;//add one minitue
    }
    seconds += inc;//add the incrament
  }
  public void unStop(){//incase we need to undo the stop
    running = true;//we actualy are going
    //undo the incrament
    if(seconds < inc){
      seconds += 60;
      minutes --;
    }
    seconds -= inc;
  }
  public void tickOne(double unit){//ticks one unit
    if(running){//if this is running
      if(seconds < unit){//if there are not enough seconds
        if(minutes > 0){//if there is atleast one minute left
          seconds += 60;//increase seconds by 60
          minutes --;//decrement minutes
        } else {//we are out of time
          this.stop();//stop myself
          gameOver = 2 - s;//the game is over, somebody one
          reasonForGO = 2;//it was a time out
        }
      }
      seconds -= unit;//decrement the number of seconds
    }
  }
  public String mins(){//get the minutes as a string
    return minutes + "";
  }
  public String secs(){//gets the seconds as a string
    if(minutes == 0 && seconds < 10){//if there are less than ten seconds remaining
      if(Math.round(seconds * 100) % 10 == 0){//if the number of seconds rounded to the hundreths is a multiple of.1
      //add a 0 to the begining and end of the number of seconds rounded to the hundreths
        return "0" + Math.round(seconds * 100)/100.0 + "0";
      }else {//otherwise
      //add a 0 to the beginning of the number of seconds rounded to the hundreths
        return "0" + Math.round(seconds * 100)/100.0;
      }
    } else if(seconds < 10){//if there are less than 10 seconds before the minute changes
      return "0" + (int) seconds;//add a 0 in front to keep the time the same length
    } else {//otherwise
      return "" + (int) seconds;//return the seconds as an int
    }
  }
  //draws the timer
  public void display(){
    fill(#ffffff);//sets the background color
    rect(x, y, 100, 32);//draws a rect
    fill(#000000);//sets the text color
    textAlign(CENTER, CENTER);//aligns the text
    text(mins() + ":" + secs(), x + 50, y+16);//put the time on the clock
  }
}
