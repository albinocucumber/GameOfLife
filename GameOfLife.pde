import de.bezier.guido.*;
public final static int NUM_ROWS = 20, NUM_COLS = 20;//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  Interactive.make( this );
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++)
    for(int c = 0; c < NUM_COLS; c++)
      buttons[r][c] = new Life(r,c);
  for(int r = 0; r < NUM_ROWS; r++)
    for(int c = 0; c < NUM_COLS; c++)
      buffer = new boolean[r][c];
}

public void draw () {
  background(0);
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();
  for(int r = 0; r < NUM_ROWS - 1; r++){
    for(int c = 0; c < NUM_COLS - 1; c++){
      if(countNeighbors(r,c) == 3){
        buffer[r][c] = true;
      } else if(countNeighbors(r,c) == 2 && buttons[r][c].getLife()){
        buffer[r][c] = true;
      } else {
        buffer[r][c] = false;
      }
      buttons[r][c].draw();
    }
  }
  copyFromBufferToButtons();
  
}

public void keyPressed() {
  if(key == ' '){
    running = !running;
  }
}

public void copyFromBufferToButtons() {
  for(int i = 0; i < buffer.length; i++){
    for(int j = 0; j < buffer[0].length; j++){
      if(buffer[i][j]){
        buttons[i][j].setLife(true);
      } else {
        buttons[i][j].setLife(false);
      }
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int i = 0; i < buttons.length - 1; i++){
    for(int j = 0; j < buttons[0].length - 1; j++){
      if(buttons[i][j].getLife()){
        buffer[i][j] = true;
      } else {
        buffer[i][j] = false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  return((r < NUM_ROWS && r >= 0) && (c < NUM_COLS && c >= 0));
}

public int countNeighbors(int row, int col) {
  int numNeighbors = 0;
  if(isValid(row+1,col+1) && buttons[row+1][col+1].getLife()) numNeighbors+=1;
  if(isValid(row+1,col-1) && buttons[row+1][col-1].getLife()) numNeighbors+=1;
  if(isValid(row+1,col) && buttons[row+1][col].getLife()) numNeighbors+=1;
  if(isValid(row-1,col-1) && buttons[row-1][col-1].getLife()) numNeighbors+=1;
  if(isValid(row-1,col+1) && buttons[row-1][col+1].getLife()) numNeighbors+=1;
  if(isValid(row-1,col) && buttons[row-1][col].getLife()) numNeighbors+=1;
  if(isValid(row,col+1) && buttons[row][col+1].getLife()) numNeighbors+=1;
  if(isValid(row,col-1) && buttons[row][col-1].getLife()) numNeighbors+=1;
  return numNeighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill(150);
    rect(x, y, width, height);
  }
  public boolean getLife() {
    if(alive){
      return true;
    }else{
      return false;
    }
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
