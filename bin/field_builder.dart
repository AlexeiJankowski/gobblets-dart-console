import 'dart:io';

import './models/player.dart';

class FieldBuilder {
  static void printField(Player player, List<String> sequence) {
    FieldBuilder field = FieldBuilder();
    var horizontal = '-';
    stdout.writeln();

    //fieldString build
    String fieldString = "";
    for (int i = 0; i < 9; i = i + 3) {
      fieldString += '${field.buildLine()}\n';
      for (int j = 0; j < 3; j++) {
        fieldString += field.buildWithPiece(sequence[i + j]);
        if (j < 2) {
          fieldString += '|';
        } else {
          fieldString += '\n';
        }
      }
      fieldString += '${field.buildLine()}\n';
      if (i < 6) {
        fieldString += '${field.buildHorizontal()}\n';
      }
    }

    stdout.writeln(fieldString);
    stdout.writeln();
  }

  String buildLine() {
    var lineBuffer = StringBuffer();
    for (int i = 0; i < 2; i++) {
      lineBuffer.write('${' ' * 7}|');
    }
    lineBuffer.write(' ' * 7);
    return lineBuffer.toString();
  }

  String buildWithPiece(String piece) {
    return piece.isEmpty ? ' ' * 5 : '  $piece  ';
  }

  String buildHorizontal({String horizontal = '-'}) {
    var horizontalBuffer = StringBuffer();
    for (int i = 0; i < 2; i++) {
      horizontalBuffer.write('${horizontal * 7}+');
    }
    horizontalBuffer.write(horizontal * 7);
    return horizontalBuffer.toString();
  }
}
