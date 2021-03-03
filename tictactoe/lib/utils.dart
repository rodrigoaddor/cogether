extension MatrixUtils<E> on List<List<E>> {
  List<List<E>> transposed() {
    return List.generate(this[0].length, (i) => List.generate(this.length, (j) => this[j][i]));
  }

  List<List<E>> diagonals() {
    List<E> diagonal = [];
    List<E> reversed = [];
    for (var i = 0; i < length; i++) {
      diagonal.add(this[i][i]);
      reversed.add(this[i][this[i].length - i - 1]);
    }

    return [diagonal, reversed];
  }
}

extension ListUtils<E> on List<E> {
  bool same([excludeNull = true]) {
    return (!excludeNull || this.first != null) && this.every((e) => e == this[0]);
  }
}
