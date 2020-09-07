import java.util.List;
import java.util.LinkedList;

public class Segment {
  private List<Point> points = new LinkedList<Point>();
  
  public Segment() {}
  
  public Segment(Point p) {
    addPoint(p);
  }
  
  public void addPoint(Point p) {
    points.add(p);
  }
  
  public List<Point> getPoints() {
    return points;
  }
  
  @Override
  public String toString() {
    String str = "";
    for (Point p : points) {
      str += "(" + p.getX() + ", " + p.getY() + ")";
    }
    return str;
  }
}
