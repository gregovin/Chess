class Timer{
  private int minutes;
  private double seconds;
  private int inc;
  private boolean running;
  private int x;
  private int y;
  private int s;
  public Timer(int x, int y, int side){
    minutes = 15;
    seconds = 0;
    this.x = x;
    this.y = y;
    inc = 15;
    running = false;
    s = side;
  }
  public Timer(int x, int y, int min, int inc, int side){
    minutes = min;
    seconds = 0;
    this.inc = inc;
    running = false;
    this.x = x;
    this.y = y;
    s = side;
  }
  public void start(){
    running = true;
  }
  public void stop(){
    running = false;
    if(seconds >= 60 - inc){
      seconds -= 60;
      minutes ++;
    }
    seconds += inc;
  }
  public void unStop(){
    running = true;
    if(seconds < inc){
      seconds += 60;
      minutes --;
    }
    seconds -= inc;
  }
  public void tickOne(double unit){
    if(running){
      if(seconds < unit){
        if(minutes > 0){
          seconds += 60;
          minutes --;
        } else {
          this.stop();
          gameOver = 2 - s;
          reasonForGO = 2;
        }
      }
      seconds -= unit;
    }
  }
  public String mins(){
    return minutes + "";
  }
  public String secs(){
    if(minutes == 0 && seconds < 10){
      if(Math.round(seconds * 100) % 10 == 0){
        return "0" + Math.round(seconds * 100)/100.0 + "0";
      }else {
        return "0" + Math.round(seconds * 100)/100.0;
      }
    } else if(seconds < 10){
      return "0" + (int) seconds;
    } else {
      return "" + (int) seconds;
    }
  }
  public void display(){
    fill(#ffffff);
    rect(x, y, 100, 32);
    fill(#000000);
    textAlign(CENTER, CENTER);
    text(mins() + ":" + secs(), x + 50, y+16);
  }
}
