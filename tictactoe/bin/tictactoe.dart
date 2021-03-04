import 'dart:io';

import 'package:tictactoe/tictactoe.dart';

extension on TicTacToe {
  String get display {
    var rows = [];
    for (var i = 0; i < 3; i++) {
      rows.add(grid.skip(i * 3).take(3).map((e) => ' ' + (e?.value ?? ' ') + ' ').join('┃'));
    }
    return rows.join('\n━━━╋━━━╋━━━\n');
  }
}

void main(List<String> arguments) {
  final game = TicTacToe();

  String? error;

  void printGame() {
    stdout.write('\x1B[2J\x1B[0;0H');
    stdout.writeln('Tic Tac Toe');
    stdout.writeln();
    stdout.writeln(game.display);
    stdout.writeln();
  }

  while (!game.isFinished) {
    printGame();
    stdout.writeln('Turn: ${game.turn.value}');

    if (error != null) {
      stdout.write('\n$error\n');
      error = null;
    }

    stdout.write('Enter a cell (1-9): ');
    var cell = int.tryParse(stdin.readLineSync() ?? '');
    if (cell != null && cell >= 1 && cell <= 9) {
      if (!game.doTurn(cell - 1)) {
        error = 'Cell already filled in';
      }
    } else {
      error = 'Invalid cell';
    }
  }

  printGame();
  if (game.hasWinner) {
    stdout.writeln('${game.winner!.value} wins!');
  } else {
    stdout.writeln('It\'s a draw!');
  }
}
