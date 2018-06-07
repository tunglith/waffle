// By tunglith
// http://tunglith.com
// In use here : https://www.instagram.com/p/Bjs6grwlRbx/

drop[] drops = new drop[50];
boolean[] columns = new boolean[800];
int minSpeed = 2;
int maxSpeed = 12;
int nbOfDrops = 50;
int dropSize = 10;
int pixelsPos;

PImage img;

void setup() {
  // load image to rain on
  img = loadImage("image.jpg");
  size(800, 800);
  background(0, 0, 0);
  img.loadPixels();
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new drop();
  }
}

void draw() {
  rain();
  //saveFrame("video/frame_#####.png");
}

class drop {
  int x;
  int y;
  int speed;

  drop() {
    x = floor(random(800));
    
    //lower the possibilities of 2 drops falling in the same column
    for (int i = 0; i < 10; i++) {
      if (columns[x] == true) {
        x = floor(random(800));
      }
    }
    
    y = floor(random(-5, -800));
    speed = floor(random(minSpeed, maxSpeed));
    stroke(200, 200, 200);
    line(x, y, x, y + dropSize);
    columns[x] = true;
  }
}

void rain() {
  img.loadPixels();
  for (int i = 0; i< drops.length; i++) {
    drops[i].y += drops[i].speed;
    // if pixel is too high, take color of first pixel
    if (drops[i].y < 0) {
      pixelsPos = drops[i].x;
    }
    // else take color under the drop
    else {
      pixelsPos = floor(map(drops[i].x, 0, 800, 0, img.height)) + (floor(map(drops[i].y, 0, 800, 0, img.width)) * img.width);
    }
    stroke(red(img.pixels[pixelsPos]), green(img.pixels[pixelsPos]), blue(img.pixels[pixelsPos]));
    line(drops[i].x, drops[i].y, drops[i].x, drops[i].y +dropSize);

    // if drop dropped out of screen, create a new drop
    if (drops[i].y  + dropSize >= height) {
      drops[i] = new drop();
    }
  }
}