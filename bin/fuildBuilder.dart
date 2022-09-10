import 'dart:io';

import 'player.dart';

class FieldBuilder {
  static void printField(Player player, List<String> sequence) {
    var horizontal = '-';
    stdout.writeln();

    //fieldString build
    String fieldString = "";
    for (int i = 0; i < 9; i = i + 3) {
      fieldString += '${buildLine()}\n';
      for (int j = 0; j < 3; j++) {
        fieldString += buildWithPiece(sequence[i + j]);
        if (j < 2) {
          fieldString += '|';
        } else {
          fieldString += '\n';
        }
      }
      fieldString += '${buildLine()}\n';
      if (i < 6) {
        fieldString += buildHorizontal(horizontal) + '\n';
      }
    }

    stdout.writeln(fieldString);
    stdout.writeln();
  }

  static String buildLine() {
    var lineBuffer = StringBuffer();
    for (int i = 0; i < 2; i++) {
      lineBuffer.write('${' ' * 7}|');
    }
    lineBuffer.write(' ' * 7);
    return lineBuffer.toString();
  }

  static String buildWithPiece(String piece) {
    return '${' ' * 1} $piece ${' ' * 1}';
  }

  static buildHorizontal(String horizontal) {
    var horizontalBuffer = StringBuffer();
    for (int i = 0; i < 2; i++) {
      horizontalBuffer.write('${horizontal * 7}+');
    }
    horizontalBuffer.write(horizontal * 7);
    return horizontalBuffer.toString();
  }
}
