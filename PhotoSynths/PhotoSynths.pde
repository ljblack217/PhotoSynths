float maxLength = 50;
int maxKnuckles = 10;
int idCount;
Synth main;
boolean grow = false;
boolean reset = false;
float light = 1;
ArrayList<PVector> collision;
ArrayList<PVector> neoCollision;
void setup() {
  size(1280, 720);
  frameRate(50);
  main = new Synth(width/2, height/2, maxKnuckles);
  main.updateSynth(light);
}
void draw() {
  background(255);
  if (reset == true) {
    main = new Synth(width/2, height/2, maxKnuckles);
    main.updateSynth(light);
    reset = false;
  }
  if (grow == true) {
    main.updateSynth(light);
  }
  main.drawSynth();
  collision = neoCollision;
  neoCollision = new ArrayList<PVector>();
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
  }
}
