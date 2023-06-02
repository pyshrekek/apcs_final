static float lineDistance(PVector start, PVector end, PVector point) {
    PVector projection, temp;

    temp = PVector.sub(end, start);

    float lineLength = temp.x * temp.x + temp.y * temp.y; //lineStart.dist(lineEnd);

    if (lineLength == 0F) {
      return point.dist(start);
    }

    float t = PVector.dot(PVector.sub(point, start), temp) / lineLength;

    if (t < 0F) {
      return point.dist(start);
    }

    if (t > lineLength) {
      return point.dist(end);
    }

    projection = PVector.add(start, PVector.mult(temp, t));

    return point.dist(projection);
  }
