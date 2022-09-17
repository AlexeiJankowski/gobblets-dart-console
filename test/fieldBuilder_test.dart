import 'dart:io';

import 'package:gobblets/gobblets.dart';
import 'package:test/test.dart';

import '../bin/fieldBuilder.dart';
import '../bin/player.dart';

void main() {
  group('menu', () {
    test('build line checker', () {
      String line = FieldBuilder.buildLine();

      //passing Value in console
      expect(line, '       |       |       ');
    });

    test('build line with piece / piece is not empty', () {
      String line = FieldBuilder.buildWithPiece('+');

      expect(line, '  +  ');
    });

    test('build line with piece / piece is empty', () {
      String line = FieldBuilder.buildWithPiece('');

      expect(line, '     ');
    });

    test('buildHorizontal with argument', () {
      String horizontalLine = FieldBuilder.buildHorizontal(horizontal: '=');

      expect(horizontalLine, '=======+=======+=======');
    });

    test('buildHorizontal without argument', () {
      String horizontalLine = FieldBuilder.buildHorizontal();

      expect(horizontalLine, '-------+-------+-------');
    });
  });
}
