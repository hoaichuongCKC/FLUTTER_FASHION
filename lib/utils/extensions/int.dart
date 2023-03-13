extension IntX on int {
  String formatNumber() {
    if (this < 1000) {
      return toString();
    }
    double num = this / 1000;
    if (num < 10) {
      return '${num.toStringAsFixed(1)}k';
    }
    return '${num.round()}k';
  }
}
