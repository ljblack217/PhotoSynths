//import processing.video.*;
float maxLength = 50;
int maxKnuckles = 10;
int starting; 
int idCount;
Synth main;
//Capture cam;
boolean grow = false;
boolean reset = false;
float light = 0.5;

ArrayList<Husk> collision;
ArrayList<Husk> neoCollision;

float circleRadius;
PVector circlePos;
void setup() {
  //people = new boolean[width][height];
  circleRadius = 300;
  circlePos = new PVector(random(0+circleRadius, width-circleRadius), random(0+circleRadius, height-circleRadius));

  starting = int(random(3)+3);
  size(1280, 720);
  frameRate(50);
  main = new Synth(width/2, height/2, maxKnuckles);
  main.updateSynth(light);
}
void draw() {
  background(255);
  fill(0);
  circlePos.x = mouseX;
  circlePos.y = mouseY;
  ellipse(circlePos.x, circlePos.y, circleRadius, circleRadius);
  


  collision = neoCollision;
  neoCollision = new ArrayList<Husk>();
  if (reset == true) {
    starting = int(random(3)+3);
    main = new Synth(width/2, height/2, maxKnuckles);
    circlePos = new PVector(random(0+circleRadius, width-circleRadius), random(0+circleRadius, height-circleRadius));

    main.updateSynth(light);
    reset = false;
  }
  if (grow == true) {
    main.updateSynth(light);
  }
  main.drawSynth();

  //println(collision.size());
}
void keyPressed() {
  if (key == ' ') {
    if (grow == true) {
      grow = false;
    } else {
      grow =  true;
    }
  } else if (key == 'r') {
    reset = true;
    //} else if (key == 'w') {
    //  circlePos.y -= 5;
    //} else if (key == 'a') {
    //  circlePos.x -= 5;
    //} else if (key == 's') {
    //  circlePos.y += 5;
    //} else if (key == 'd') {
    //  circlePos.x +=5;
  }
}

class Husk {
  PVector pos;
  float angle;
  int id;
}
