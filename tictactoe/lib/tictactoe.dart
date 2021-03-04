import 'package:tictactoe/utils.dart' show ListUtils;

enum Mark { X, O }

extension MarkValue on Mark {
  String get value => toString().split('.').last;
}

class TicTacToe {
  Mark turn = Mark.X;
  List<Mark?> grid = List.filled(9, null);
  Mark? winner;

  Mark? checkVictory() {
    for (var row = 0; row <= 2; row++) {
      if (grid.same(start: row * 3, end: row * 3 + 2)) return grid[row * 3];
    }

    for (var col = 0; col <= 2; col++) {
      if (grid.same(start: col, step: 3, end: col + 6)) return grid[col];
    }

    if (grid.same(step: 4)) return grid[0];
    if (grid.same(start: 2, step: 2, end: 6)) return grid[2];
  }

  bool get hasWinner => winner != null;
  bool get isFinished => hasWinner || grid.every((e) => e != null);

  bool doTurn(int cell) {
    if (isFinished) throw StateError('Can\'t do a turn when the game has finished.');

    if (grid[cell] == null) {
      grid[cell] = turn;
      turn = turn == Mark.X ? Mark.O : Mark.X;
      winner = checkVictory();
      return true;
    }
    return false;
  }
}
