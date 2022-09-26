import 'dart:io';

import 'package:collection/collection.dart';

import 'field_builder.dart';
import 'helper.dart';
import './models/player.dart';
import 'models/field.dart';
import 'won_sequences.dart';

class MoveControl {
  void makeAMove(Player player, List<String> fieldSequence) {
    int move = 0;

    while (!(1 <= move && move <= 9)) {
      player.game.currentPieceSize = pieceSizePicker(player);
      stdout.writeln('${player.name}, it\'s your move (1-9)');

      FieldBuilder.printField(fieldSequence);

      try {
        move = int.parse(stdin.readLineSync() ?? '');
      } catch (exception) {
        move = 0;
      }

      switch (player.game.currentPieceSize) {
        case 1:
          /*unfortunatelly there is no way to change class uniqueNumbersField 
          using methods in dart (or I just don't know one), so...*/
          if (!setupMove(player, move, fieldSequence, player.field.smallField,
              Field.smallFieldGlobal, player.smallPieces - 1, ' x ', ' o ')) {
            Helper.clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            move = 0;
          } else {
            player.smallPieces--;
            Helper.clearScreen();
          }
          player.smallPieces < 0 ? player.smallPieces = 0 : player.smallPieces;
          break;
        case 2:
          player.mediumPieces--;
          if (!setupMove(player, move, fieldSequence, player.field.mediumField,
              Field.mediumFieldGlobal, player.mediumPieces - 1, ' X ', ' O ')) {
            Helper.clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            move = 0;
          } else {
            player.mediumPieces--;
            Helper.clearScreen();
          }
          player.mediumPieces < 0
              ? player.mediumPieces = 0
              : player.mediumPieces;
          break;
        case 3:
          player.bigPieces--;
          if (!setupMove(player, move, fieldSequence, player.field.bigField,
              Field.bigFieldGlobal, player.bigPieces - 1, '!X!', '!O!')) {
            Helper.clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            move = 0;
          } else {
            player.bigPieces--;
            Helper.clearScreen();
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
          player.game.won = true;
          stdout.writeln('Player ${player.name} Wins!');
        }
      });
    }
  }

  void addToFields(Player player, List<int> field) {
    field.forEach((element) {
      if (!player.field.uniqueNumbersField.contains(element)) {
        player.field.uniqueNumbersField.add(element);
      }
    });
  }

  int pieceSizePicker(Player player) {
    int pieceSize = 0;
    while (pieceSize != 1 && pieceSize != 2 && pieceSize != 3) {
      if (1 < pieceSize && pieceSize > 3) {
        Helper.clearScreen();
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
        Helper.clearScreen();
      }
    }
    return pieceSize;
  }

  bool setupMove(
      Player player,
      int move,
      List<String> fieldSequence,
      List<int> fieldSize,
      List<int> globalFieldSize,
      int pieceSize,
      String x,
      String o) {
    print('$pieceSize piecesize');
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

  bool isMoveLegal(int move, List<int> field) {
    if (field.contains(move)) {
      Helper.clearScreen();
      stdout.writeln(
          'Sorry, but it\'s not a chess game.madeAMove..\nThe one more time');
      return false;
    }
    return true;
  }

  int moveOrReplace() {
    int answer = 0;
    while (answer != 1 && answer != 2) {
      print('1.Make a move\n2.Change piece position');
      try {
        answer = int.parse(stdin.readLineSync() ?? '');
      } catch (exception) {
        answer = 0;
      }
    }
    return answer;
  }

  chooseAction(Player player, List<String> fieldSequence) {
    switch (moveOrReplace()) {
      case 1:
        makeAMove(player, fieldSequence);
        break;
      case 2:
        changePiecePosition(player, fieldSequence);
        break;
    }
  }

  changePiecePosition(Player player, List<String> fieldSequence) {
    if (player.field.uniqueNumbersField.isNotEmpty) {
      FieldBuilder.printField(fieldSequence);
      int removeFrom = moveChoose('Choose the piece you want to move');
      Helper.clearScreen();
      FieldBuilder.printField(fieldSequence);
      int moveTo = moveChoose('Choose the field part you want to move to');
      Helper.clearScreen();

      //fieldNumber 1 - small/ 2 - medium/ 3 - big
      List<int> removeInfo =
          getRemoveInfo(player.field.bigField, removeFrom, 3);
      if (removeInfo[0] == 0) {
        removeInfo = getRemoveInfo(player.field.mediumField, removeFrom, 2);
      }
      if (removeInfo[0] == 0) {
        removeInfo = getRemoveInfo(player.field.smallField, removeFrom, 1);
      }

      player.field.uniqueNumbersField.remove(removeFrom);
      player.field.uniqueNumbersField.add(moveTo);

      switch (removeInfo[1]) {
        case 1:
          player.field.smallField.remove(removeInfo[0]);
          /*unfortunatelly there is no way to change class uniqueNumbersField 
          using methods in dart (or I just don't know one), so...*/
          if (!setupMove(player, moveTo, fieldSequence, player.field.smallField,
              Field.smallFieldGlobal, 2, ' x ', ' o ')) {
            // Helper.clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            moveTo = 0;
          } else {
            Helper.clearScreen();
            fieldSequence[removeFrom - 1] = '   ';
          }
          break;
        case 2:
          player.field.mediumField.remove(removeInfo[0]);
          if (!setupMove(
              player,
              moveTo,
              fieldSequence,
              player.field.mediumField,
              Field.mediumFieldGlobal,
              2,
              ' X ',
              ' O ')) {
            Helper.clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            moveTo = 0;
          } else {
            Helper.clearScreen();
            if (player.field.smallField.contains(removeFrom)) {
              fieldSequence[removeFrom - 1] = player.piece ? ' x ' : ' o ';
            } else {
              fieldSequence[removeFrom - 1] = '   ';
            }
          }
          break;
        case 3:
          player.field.bigField.remove(removeInfo[0]);
          if (!setupMove(player, moveTo, fieldSequence, player.field.bigField,
              Field.bigFieldGlobal, 2, '!X!', '!O!')) {
            // Helper.clearScreen();
            stdout.writeln('Wrong move... Try one more time');
            moveTo = 0;
          } else {
            Helper.clearScreen();
            if (player.field.mediumField.contains(removeFrom)) {
              fieldSequence[removeFrom - 1] = player.piece ? ' X ' : ' O ';
            } else if (player.field.smallField.contains(removeFrom)) {
              fieldSequence[removeFrom - 1] = player.piece ? ' x ' : ' o ';
            } else {
              fieldSequence[removeFrom - 1] = '   ';
            }
          }
          break;
      }
    } else {
      print('You have nothing to change');
      makeAMove(player, fieldSequence);
    }
  }

  moveChoose(String message) {
    int move = 0;
    while (!(1 <= move && move <= 9)) {
      print(message);
      try {
        move = int.parse(stdin.readLineSync() ?? '');
      } catch (exception) {
        move = 0;
      }
    }
    return move;
  }

  List<int> getRemoveInfo(List<int> field, int removeFrom, int fieldNumber) {
    var toRemove = 0;
    if (field.isNotEmpty) {
      field.forEach((element) {
        if (element == removeFrom) {
          toRemove = element;
        }
      });
      return <int>[toRemove, fieldNumber];
    } else {
      return <int>[0, 0];
    }
  }
}
