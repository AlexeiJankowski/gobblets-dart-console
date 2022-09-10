import 'dart:io';

import 'field.dart';
import 'fuildBuilder.dart';
import 'player.dart';
import 'wonSequences.dart';
import 'package:collection/collection.dart';

class StartGame {
  static void gameRunner(List<Player> players) {
    //empty uniqueNumbersField
    List<String> fieldSequence = List.filled(9, '   ');
    bool won = false;

    Player player1 = players.where((p) => p.firstMove == true).first;
    Player player2 = players.where((p) => p.firstMove == false).first;

    while (!won) {
      if (player1.madeAMove == false) {
        makeAMove(player1, fieldSequence);
        player1.madeAMove = !player1.madeAMove;
      } else {
        makeAMove(player2, fieldSequence);
        player1.madeAMove = !player1.madeAMove;
      }

      if (player1.won == true || player2.won == true) {
        won = true;
      }
    }
  }

  static void makeAMove(Player player, List<String> fieldSequence) {
    int move = 0;

    while (!(1 <= move && move <= 9)) {
      player.currentPieceSize = pieceSizePicker(player);
      stdout.writeln('${player.name}, it\'s your move (1-9)');

      FieldBuilder.printField(player, fieldSequence);

      try {
        move = int.parse(stdin.readLineSync() ?? '');
      } catch (exception) {
        move = 0;
      }

      switch (player.currentPieceSize) {
        case 1:
          /*unfortunatelly there is no way to change class uniqueNumbersField 
          using methods in dart (or I just don't know one), so...*/
          if (!setupMove(player, move, fieldSequence, player.field.smallField,
              Field.smallFieldGlobal, player.smallPieces - 1, ' x ', ' o ')) {
            clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            move = 0;
          } else {
            player.smallPieces--;
            clearScreen();
          }
          player.smallPieces < 0 ? player.smallPieces = 0 : player.smallPieces;
          break;
        case 2:
          player.mediumPieces--;
          if (!setupMove(player, move, fieldSequence, player.field.mediumField,
              Field.mediumFieldGlobal, player.mediumPieces - 1, ' X ', ' O ')) {
            clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            move = 0;
          } else {
            player.mediumPieces--;
            clearScreen();
          }
          player.mediumPieces < 0
              ? player.mediumPieces = 0
              : player.mediumPieces;
          break;
        case 3:
          player.bigPieces--;
          if (!setupMove(player, move, fieldSequence, player.field.bigField,
              Field.bigFieldGlobal, player.bigPieces - 1, '!X!', '!O!')) {
            clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            move = 0;
          } else {
            player.bigPieces--;
            clearScreen();
          }
          player.bigPieces < 0 ? player.bigPieces = 0 : player.bigPieces;
          break;
      }
      //Make List<List<int>>
      addToFields(player, player.field.smallField);
      addToFields(player, player.field.mediumField);
      addToFields(player, player.field.bigField);

      wonSequences.forEach((sequence) {
        if (ListEquality<int>()
            .equals(player.field.uniqueNumbersField, sequence)) {
          player.won = true;
          stdout.writeln('Player ${player.name} Wins!');
        }
      });
    }
  }

  static void addToFields(Player player, List<int> field) {
    field.forEach((element) {
      if (!player.field.uniqueNumbersField.contains(element)) {
        player.field.uniqueNumbersField.add(element);
      }
    });
  }

  static int pieceSizePicker(Player player) {
    int pieceSize = 0;
    while (pieceSize != 1 && pieceSize != 2 && pieceSize != 3) {
      if (1 < pieceSize && pieceSize > 3) {
        clearScreen();
      }
      stdout.writeln(
          '${player.name}, choose your piece size\n1.Small\n2.Medium\n3.Big');
      stdout.writeln('You have: ${player.smallPieces} small pieces | '
          '${player.mediumPieces} medium pieces | '
          '${player.bigPieces} big pieces.');
      try {
        pieceSize = int.parse(stdin.readLineSync() ?? '');
      } catch (exception) {
        pieceSize = 0;
        clearScreen();
      }
    }
    return pieceSize;
  }

  static bool setupMove(
      Player player,
      int move,
      List<String> fieldSequence,
      List<int> fieldSize,
      List<int> globalFieldSize,
      int pieceSize,
      String x,
      String o) {
    if (pieceSize >= 0 && isMoveLegal(move, globalFieldSize)) {
      globalFieldSize.add(move);
      fieldSize.add(move);
      if (player.piece) {
        fieldSequence[move - 1] = x;
      } else {
        fieldSequence[move - 1] = o;
      }
      return true;
    }
    return false;
  }

  static bool isMoveLegal(int move, List<int> field) {
    if (field.contains(move)) {
      clearScreen();
      stdout.writeln('Sorry, but it\'s not a chess game...\nThe one more time');
      return false;
    }
    return true;
  }

  static void clearScreen() {
    print("\x1B[2J\x1B[0;0H");
  }
}
