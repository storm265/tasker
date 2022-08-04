extension ColorString on String {
  String toStringColor() =>
      replaceAll('Color(0xff', '#').replaceAll(')', '').toUpperCase();
}
