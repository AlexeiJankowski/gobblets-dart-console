import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';

import '../bin//models/player.dart';
import '../bin/field_builder.dart';

void main() {
  group('menu', () {
    FieldBuilder field = FieldBuilder();
    var log = [];
    Player player = Player(name: 'ALX', piece: true, firstMove: true);
    List<String> sequence = List.filled(9, '   ');
    void Function() overridePrint(void testFunction()) => () {
          var spec = new ZoneSpecification(print: (_, __, ___, String message) {
            log.add(message);
          });
          return Zone.current.fork(specification: spec).run<void>(testFunction);
        };
    test('builds a field of 264 symbols', overridePrint(() {
      FieldBuilder.printField(sequence);

      expect(log[0].length, 264);
    }));

    test('build line checker', () {
      String line = field.buildLine();

      //passing Value in console
      expect(line, '       |       |       ');
      expect(line.length, 23);
    });

    test('build line with piece / piece is not empty', () {
      String line = field.buildWithPiece('+');

      expect(line, '  +  ');
      expect(line.length, 5);
    });

    test('build line with piece / piece is empty', () {
      String line = field.buildWithPiece('');

      expect(line, '     ');
      expect(line.length, 5);
    });

    test('buildHorizontal with argument', () {
      String horizontalLine = field.buildHorizontal(horizontal: '=');

      expect(horizontalLine, '=======+=======+=======');
      expect(horizontalLine.length, 23);
    });

    test('buildHorizontal without argument', () {
      String horizontalLine = field.buildHorizontal();

      expect(horizontalLine, '-------+-------+-------');
      expect(horizontalLine.length, 23);
    });
  });
}
