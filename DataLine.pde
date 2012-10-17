class DataLine {
  float value; //grayscale stroke
  float x1, y1, x2, y2;
  PGraphics pg;

  DataLine( float _value, float _x1, PGraphics _pg) {
    value = _value;
    x1 = _x1;
    y1 = 0;
    x2 = _x1;
    y2 = _pg.height;
    pg = _pg;
  }

  void render() {
    stroke(value);
    strokeWeight(2);
    line(x1, y1, x1, y2);
  }

  void update() {
    x1--;

    if (x1 < 0) {
      x1 = pg.width;
    }
  }
}
