extension RemoveLastElement on String {
  String removeLastElement() {
    return substring(0, length - 1);
  }
}