class Synth {
  ArrayList<Knuckle> branches;
  PVector center;

  Synth(float x, float y, int knuckleMax) {
    idCount = 0;
    collision = new ArrayList<Husk>();
    neoCollision = new ArrayList<Husk>();
    center = new PVector(x, y);
    int knStart = starting;
    branches = new ArrayList<Knuckle>();
    for (int s = 0; s<knStart; s++) {
      Knuckle newKnuckle = new Knuckle(radians(((360/knStart)*s)+random(45)), knuckleMax, 20); 
      branches.add(newKnuckle);
      //collision.add(center);
      //print("setup, " + newKnuckle.angle);
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
  float targetx, targety;
  Knuckle(float inangle, int inmax, float inlen) {
    id = idCount;
    idCount++;
    end = new PVector();
    angle = inangle;
    max = inmax-1;
    if (int(random(3)) == 0) {
      twoChild = true; // 2 for loop iterations later
    } else {
      twoChild = false;
    }
    children = new ArrayList<Knuckle>();
    len = inlen;
  }
  void update(float light, PVector pPos, float pAngle) {
    //angle = angleCheck(angle);

    //angle = angleCheck(angle);
    start = pPos;
    targetx = end.x;
    targety = end.y;
    //println(targetx,targety);

    //collisionCheck();
    externalCheck();

    if (targetx != end.x && targety != end.y) {
      float disX = targetx - start.x;
      float disY = targety - start.y;
      println(disX, disY); 
      //print("id",id,angle, atan2(dY, dX));
      angle = atan2(disY, disX);
    }
    end.x = pPos.x + cos(angle) * len;
    end.y = pPos.y + sin(angle) * len;

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
          //childAngle = angleCheck(childAngle);
          children.add(new Knuckle(childAngle, max, 0));
          childAngle = angle + radians(random(5, 45));
          twoChild = false;
        }
        //childAngle = angleCheck(childAngle);
        children.add(new Knuckle(childAngle, max, 0));
      }
    }
    //positioning



    //angle = PVector.angleBetween(end,start);

    Husk neo = new Husk();
    neo.pos = end;
    neo.id = id;
    neo.angle = angle;
    neoCollision.add(neo);

    //println(angle);


    //update the children
    if (children.size()>0) {
      for (Knuckle child : children) {
        child.update(light, end, angle);
      }
    }
  }
  void drawKnuckle(float sX, float sY) {
    fill(255);
    line(end.x, end.y, sX, sY);
    ellipse(end.x, end.y, 20, 20);
    fill(0);
    //text(id, end.x, end.y);
    for (Knuckle child : children) {
      child.drawKnuckle(end.x, end.y);
    }
  }
  void collisionCheck() {
    //println(id);
    for (int i = id+2; i<collision.size(); i++) {
      Husk compare = collision.get(i);
      //println(degrees(compare.angle), compare.id);
      float distance = compare.pos.dist(end);
      boolean childrenCheck = false;
      for (Knuckle child : children) {

        if (child.id == compare.id) {
          //println(child.end.x, child.end.y, compare.pos.x, compare.pos.y);
          childrenCheck = true;
          //println(compare.id, ",", child.id);
        }
      }
      if (distance<20 && childrenCheck == false && id>starting) {
        //println("collided");
        //println(childrenCheck);
        float dX = compare.pos.x - end.x;
        float dY = compare.pos.y - end.y;
        float colAngle = atan2(dY, dX);
        targetx = end.x + cos(colAngle)*20;
        targety = end.y + sin(colAngle)*20;
      }
    }
  }
  void externalCheck() {
    float distance = PVector.dist(end,circlePos);
    if (distance<10+(circleRadius/2)){
      float diX = circlePos.x - end.x;
      float diY = circlePos.y - end.y;
      float coliAngle = atan2(diY,diX);
      float sX = circlePos.x - start.x;
      float sY = circlePos.y-start.y;
      float sAngle = atan2(sY,sX);
      
      
      
      if (sAngle>coliAngle){
      angle = angle +radians(1);
      } else {
        angle = angle -radians(1);
      }
    }
  }

  float angleCheck(float pre) {
    float neoAngle;
    neoAngle = pre;
    if (neoAngle>2*PI) {
      while (neoAngle>2*PI) {
        neoAngle = neoAngle - (2*PI);
      }
    } else if (neoAngle<0) {
      while (neoAngle<0) {
        neoAngle = neoAngle + (2*PI);
      }
    }

    return neoAngle;
  }
}
