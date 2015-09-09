import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// MINIM

Minim minim;
AudioInput in;

// END MINIM

float speed = 5;
float wind = 1;
float rad = 10;

Rain r1;

int numDrops = 300;
Rain[] drops = new Rain[numDrops]; // Declare and create the array

void setup() 
{
  //CANVAS AND DRAWING
  
  size(displayWidth, displayHeight);
  strokeWeight(1);
  
  frameRate(30);
  ellipseMode(RADIUS);
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Rain(); // Create each object
    r1 = new Rain();
  }
  
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.STEREO, 512);
  
  
  
}

void draw() 
{
  background(#000000);
  wind = (mouseX-displayWidth/2) / 10;
  for (int i = 0; i < drops.length; i++) {
    drops[i].update();
  }
}


class Rain {
  float startxpos = 50 + random(displayWidth-150);
  float startypos = 50 + random(displayHeight-150);
  float xpos = startxpos;
  float ypos = startxpos;
  float zindex = random(4);
  float angle = random(TWO_PI);
  float lineLength = 50;
  float distance = random(10,100);
  float volumeLevel = 0;
  
  void update() {
   if (zindex < 4) stroke(#00ffff, 102);
    if (zindex < 3) stroke(#00ffff, 153);
    if (zindex < 2) stroke(#00ffff, 204);
    if (zindex < 1) stroke(#00ffff, 255);
    
    //INCREMENT SPEED 
   // POINT AWAY
   angle = atan2(startxpos-mouseX, startypos-mouseY);
   
   volumeLevel = in.right.level()*1000;
   
   distance = volumeLevel + sqrt(sq(startxpos-mouseX)+sq(startypos-mouseY))/10;
   
   //POINT TO
   //angle = atan2(mouseX-startxpos, mouseY-startypos);
   
   xpos = startxpos+(((distance)*sin(angle)));
   ypos = startypos+(((distance)*cos(angle)));
   
   line(startxpos, startypos, xpos, ypos);
    

    
    
  }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  super.stop();
}

