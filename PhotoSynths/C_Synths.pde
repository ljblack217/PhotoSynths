class Synth {
  ArrayList<Knuckle> branches;
  PVector center;
  Synth(float x, float y) {
    center = new PVector(x, y);
    int knStart = int(random(3)+1);
    branches = new ArrayList<Knuckle>();
    for (int s = 0; s<knStart; s++) {
      Knuckle newKnuckle = new Knuckle(360/(knStart+1)); 
      branches.add(newKnuckle);
      print("setup, " + newKnuckle.angle);
    }
  }
  void updateSynth() {
    for (Knuckle current : branches) {
      current.update(10, center, current.angle);
    }
  }
  void drawSynth() {
    for (Knuckle drawing : branches) {
      drawing.drawKnuckle(center.x, center.y);
    }
  }
}

class Knuckle {
  float len;
  PVector end;
  boolean twoChild;
  float angle;
  ArrayList<Knuckle> children;

  Knuckle(float inangle) {
    end = new PVector();
    angle = inangle;
    if (int(random(5)) == 0) {
      twoChild = true; // 2 for loop iterations later
    } else {
      twoChild = false;
    }
    children = new ArrayList<Knuckle>();
    len = 0;
  }
  void update(float light, PVector pPos, float pAngle) {


    if (len<maxLength) {
      if (end.x<0||end.x>width||end.y<0||end.y>height) {
        
      }else{
        len = len + light;
      }
    } else {
      if (children.size() == 0) {
        float childAngle = angle;
        if (twoChild) {
          childAngle = angle - random(90);

          children.add(new Knuckle(childAngle));

          childAngle = angle + random(90);
          twoChild = false;
        }
        children.add(new Knuckle(childAngle));
      }
    }
    //positioning
    if (end.x<0||end.x>width||end.y<0||end.y>height) {
      end.x = end.x;
      end.y = end.y;
    } else {

      end.x = pPos.x + cos(angle) * len;
      end.y = pPos.y + sin(angle) * len;
    }
    //println(angle);


    //update the children
    if (children.size()>0) {
      for (Knuckle child : children) {
        child.update(light, end, angle);
      }
    }
  }
  void drawKnuckle(float sX, float sY) {
    line(end.x, end.y, sX, sY);
    ellipse(end.x, end.y, 20, 20);
    for (Knuckle child : children) {
      child.drawKnuckle(end.x, end.y);
    }
  }
}
