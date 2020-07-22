class Synth {
  ArrayList<Knuckle> branches;
  PVector center;

  Synth(float x, float y, int knuckleMax) {
    idCount = 0;
    collision = new ArrayList<PVector>();
    neoCollision = new ArrayList<PVector>();
    center = new PVector(x, y);
    int knStart = int(random(3)+3);
    branches = new ArrayList<Knuckle>();
    for (int s = 0; s<knStart; s++) {
      Knuckle newKnuckle = new Knuckle(radians(((360/knStart)*s)+random(45)), knuckleMax, 20); 
      branches.add(newKnuckle);
      collision.add(center);
      print("setup, " + newKnuckle.angle);
    }
  }
  void updateSynth(float inlight) {
    for (Knuckle current : branches) {
      current.update(inlight, center, current.angle);
    }
  }
  void drawSynth() {
    if (branches.size() > 0) {
      for (Knuckle drawing : branches) {
        drawing.drawKnuckle(center.x, center.y);
      }
    }
  }
}

class Knuckle {
  float len;
  int id;
  PVector end;
  boolean twoChild;
  float angle;
  ArrayList<Knuckle> children;
  int max;
  PVector start;
  Knuckle(float inangle, int inmax, float inlen) {
    id = idCount;
    idCount++;
    end = new PVector();
    angle = inangle;
    max = inmax-1;
    if (int(random((20-max)/3)) == 0) {
      twoChild = true; // 2 for loop iterations later
    } else {
      twoChild = false;
    }
    children = new ArrayList<Knuckle>();
    len = inlen;
  }
  void update(float light, PVector pPos, float pAngle) {
    
    start = pPos;
    if (len<maxLength) {
      if (end.x<0||end.x>width||end.y<0||end.y>height) {
      } else {
        len = len + light;
      }
    } else if (max>0) {
      if (children.size() == 0) {
        float childAngle = angle;
        if (twoChild) {
          childAngle = angle - radians(random(5, 45));

          children.add(new Knuckle(childAngle, max, 0));

          childAngle = angle + radians(random(5, 45));
          twoChild = false;
        }
        children.add(new Knuckle(childAngle, max, 0));
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
    neoCollision.add(end);
    collisionCheck();
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
  void collisionCheck() {
    println(id);
    for (int i = id+1; i<collision.size(); i++) {
      PVector compare = collision.get(i);
      float distance = compare.dist(end);
      boolean childrenCheck = false;
      for (Knuckle child : children) {
        //println(i,",",child.id);
        if (child.id == i) {
          childrenCheck = true;
        }
      }
      if (distance<20 && childrenCheck == false) {
        //println("collided");
        //println(childrenCheck);
        float colAngle = PVector.angleBetween(start, compare);
        if (angle<colAngle) {
          angle = angle - radians(1);
        } else {
          angle = angle + radians(1);
        }
      }
    }
  }
}
