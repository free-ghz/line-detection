import java.util.List;
import java.util.ArrayList;


PImage input;
int width = 100;
int height = 100;
SearchState[][] searchState = new SearchState[width][height];
Image image = new Image();

void setup() {
  size(800, 800);
  noSmooth();
  input = loadImage("teapot.png");
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      searchState[i][j] = SearchState.BLIND;
    }
  }
  
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      if (input.get(i, j) == color(#000000) && searchState[i][j] == SearchState.BLIND) {
        startLineFind(i, j);
      }
    }
  }
  println("Found " + image.size() + " lines.");
  SvgBuilder svgBuilder = new SvgBuilder();
  String output = svgBuilder.convertToSvgString(image);
  saveStrings("output.svg", new String[]{output});
}

void startLineFind(int x, int y) {
  if (searchState[x][y] == SearchState.BLIND) {
    Segment line = new Segment();
    image.add(line);
    recursiveLineFind(x, y, line);
  }
}
void recursiveLineFind(int x, int y, Segment line) {
  line.add(new Point(x, y));
  searchState[x][y] = SearchState.VISITED;
  List<Point> possibleDirections = new ArrayList<Point>();
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j <2; j++) {
      if (i == 0 && j == 0) continue; // identity
      int searchX = x + i;
      int searchY = y + j;
      if (searchX < 0 || searchY < 0) continue; // min bounds
      if (searchX == width || searchY == height) continue; // max bounds
      
      if (input.get(searchX, searchY) == color(#000000) && searchState[searchX][searchY] == SearchState.BLIND) {
        possibleDirections.add(new Point(searchX, searchY));
      }
    }
  }
  
  if (possibleDirections.size() > 0) {
    // continue the line
    recursiveLineFind(possibleDirections.get(0).getX(), possibleDirections.get(0).getY(), line);
  }
  for (int i = 1; i < possibleDirections.size(); i++) {
    // create new lines if this one splits
    startLineFind(possibleDirections.get(i).getX(), possibleDirections.get(i).getY());
  }
}

void draw() {
  clear();
  stroke(#000000);
  strokeWeight(2);
  float offset = 150;
  float sinus = sin(frameCount/200.0);
  float scale = (sinus+6);
  offset = offset - ((offset * sinus)/4);
  for (Segment line : image) {
    if (line.size() > 1) {
      // line
      for (int i = 0; i < line.size() - 1; i++) {
        Point a = line.get(i);
        Point b = line.get(i+1);
        float drawAX = (a.getX() * scale) + offset;
        float drawAY = (a.getY() * scale) + offset;
        float drawBX = (b.getX() * scale) + offset;
        float drawBY = (b.getY() * scale) + offset;
        line(drawAX, drawAY, drawBX, drawBY);
      }
    } else if (line.size() == 1) {
        Point a = line.get(0);
        float px = (a.getX() * scale) + offset;
        float py = (a.getY() * scale) + offset;
        float s = scale/2;
        line(px - s, py, px, py - s);
        line(px, py - s, px + s, py);
        line(px + s, py, px, py + s);
        line(px, py + s, px - s, py);
    }
  }
}

void clear() {
  noStroke();
  fill(#cccccc);
  rect(0, 0, 800, 800);
  image(input, 0, 0);
}
