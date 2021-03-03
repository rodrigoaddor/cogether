import 'dart:io';

import 'package:tictactoe/utils.dart' show MatrixUtils, ListUtils;

enum Mark { X, O }

extension on Mark {
  String get value => toString().split('.').last;
}

class Game {
  Mark turn = Mark.X;
  Mark winner;
  List<List<Mark>> marks = List.generate(3, (i) => List(3));

  Mark checkVictory() {
    for (final row in marks) {
      if (row.same()) return row.first;
    }

    for (final column in marks.transposed()) {
      if (column.same()) return column.first;
    }

    for (final diagonal in marks.diagonals()) {
      if (diagonal.same()) return diagonal.first;
    }

    return null;
  }

  // ━ ┃ ╋
  // ─ │ ┼
  String get display =>
      marks.map((row) => ' ' + row.map((e) => e?.value ?? ' ').join(' ┃ ') + ' ').join('\n━━━╋━━━╋━━━\n');
  // String get display => marks.map((row) => ' ' + row.map((e) => e ?? ' ').join(' │ ') + ' ').join('\n───┼───┼───\n');

  void run() {
    String error = '';
    while (winner == null) {
      print("\x1B[2J\x1B[0;0H"); // Move term (clear)
      print('Tic Tac Toe');
      print('');
      print(display);
      print('');

      winner = checkVictory();
      if (winner != null || marks.every((row) => row.every((e) => e != null))) break;

      print('\nTurn: ${turn.value}');
      print('');
      print(error);
      print('');

      stdout.write('Enter a cell (1-9): ');
      int cell = int.tryParse(stdin.readLineSync());

      error = '';

      if (cell != null && cell >= 1 && cell <= 9) {
        final x = ((cell - 1) / 3).floor();
        final y = (cell - 1) % 3;

        if (marks[x][y] == null) {
          marks[x][y] = turn;

          turn = turn == Mark.X ? Mark.O : Mark.X;
        } else {
          error = 'Cell already filled in!';
        }
      } else {
        error = 'Invalid cell!';
      }
    }

    if (winner != null) {
      print('${winner.value} wins!');
    } else {
      print('It\'s a draw!');
    }
  }
}
