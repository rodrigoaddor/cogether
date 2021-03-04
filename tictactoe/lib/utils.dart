extension ListUtils<E> on List<E> {
  bool same({int start = 0, int step = 1, int? end, bool excludeNull = true}) {
    for (var i = start; i <= (end ?? (length - 1)); i += step) {
      if ((excludeNull && this[i] == null) || this[i] != this[start]) {
        return false;
      }
    }
    return true;
  }
}
