// TODO: add of the files from Extensions package should not be placed in Services package.
extension ColorString on String {
  String toStringColor() =>
      replaceAll('Color(0xff', '#').replaceAll(')', '').toUpperCase();

  String replaceColorSymbol() => '0xff${substring(1)}';
}
