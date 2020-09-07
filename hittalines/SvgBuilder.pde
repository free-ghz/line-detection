import java.lang.StringBuilder;

public class SvgBuilder {
  public String convertToSvgString(Image image) {
     StringBuilder builder = new StringBuilder();
     builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n");
     builder.append("<svg viewBox=\"0 0 100 100\" xmlns=\"http://www.w3.org/2000/svg\">\n");
     builder.append("<g fill=\"none\" stroke=\"#000000\" stroke-width=\"0.2\">\n");
     for (Segment s : image) {
       StringBuilder lineBuilder = new StringBuilder();
       lineBuilder.append("<polyline points=\"");
       for (Point p : s) {
         lineBuilder.append(p.getX()).append(",").append(p.getY()).append(" ");
       }
       lineBuilder.append("\" />\n");
       builder.append(lineBuilder);
     }
     builder.append("</g></svg>");
     return builder.toString();
  }
}
