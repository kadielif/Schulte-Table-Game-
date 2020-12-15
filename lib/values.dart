import 'dart:math';

class Values {
  static List<int> values = List<int>();
  static List<int> colorValues = List<int>();
  static List<int> getValue() {
    // List tempValues;
    if (values.length == 25) {
      values = new List<int>();
    }
    var rng = new Random();
    values.add(rng.nextInt(25));

    for (int i = 1; i < 25; i++) {
      var x = rng.nextInt(25);
      if (values.contains(x + 1) == false) {
        values.add(x + 1);
      } else {
        i--;
      }
    }
    return values;
  }

  static List<int> getColorValue() {
    if (colorValues.length == 25) {
      colorValues = new List<int>();
    }
    for (int i = 0; i < 25; i++) {
      colorValues.add(1);
    }
    return colorValues;
  }
}
