import 'dart:io';

import 'package:gobblets/gobblets.dart';
import 'package:test/test.dart';

import '../bin/menu.dart';
import '../bin/player.dart';

void main() {
  group('menu', () {
    test('playerName defined should return passed value', () async {
      String name = Menu.playerName('Name');

      //passing Value in console
      expect(name, 'Value');
    });

    test('playerName undefined should return Name', () {
      String name = Menu.playerName('Name');

      //passing empty field
      expect(name, 'Name');
    });
  });
}
