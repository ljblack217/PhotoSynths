float maxLength = 100;
Synth main;

void setup(){
  size(1280,720);
  frameRate(50);
  main = new Synth(width/2, height/2);
}
void draw(){
  background(255);
  main.updateSynth();
  main.drawSynth();

}
