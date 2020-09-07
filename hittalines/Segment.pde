import java.util.List;
import java.util.LinkedList;

public class Segment extends LinkedList<Point> {
  public Segment() {
    super();
  }
  
  public Segment(Point p) {
    super();
    add(p);
  }
  
  @Override
  public String toString() {
    String str = "";
    for (Point p : this) {
      str += "(" + p.getX() + ", " + p.getY() + ")";
    }
    return str;
  }
}
