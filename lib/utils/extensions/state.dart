extension CustomMapList<T, R> on List<T> {
  List<R> customMap(R Function(T) mapper) {
    return map(mapper).toList();
  }
}
