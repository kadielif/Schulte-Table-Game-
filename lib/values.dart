import 'dart:math';

class Values {
  static List<int> getValue() {
    List<int> values = List<int>();
    var rng = new Random();
    if (values.length == 25) {
      values = new List<int>();
    }
    for (int i = 0; i < 25; i++) {
      var x = rng.nextInt(25);
      !values.contains(x + 1) ? values.add(x + 1) : i--;
    }
    return values;
  }

  static List<int> getColorValue() {
    List<int> colorValues = List<int>();
    if (colorValues.length == 25) {
      colorValues = new List<int>();
    }
    for (int i = 0; i < 25; i++) {
      colorValues.add(1);
    }
    return colorValues;
  }
}
