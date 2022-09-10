import 'dart:io';

import 'player.dart';

class Menu {
  static List<Player> playerBuilder() {
    const int size = 2;
    List<Player> players = new List.empty(growable: true);

    Player player1 = new Player(
        name: playerName('player 1'),
        piece: piecePicker(),
        firstMove: firstMove());
    Player player2 = new Player(
        name: playerName('player 2'),
        piece: !player1.piece,
        firstMove: !player1.firstMove);

    players.add(player1);
    players.add(player2);

    return players;
  }

  static String playerName(String player) {
    String? name = "";
    if (name != null && name.isEmpty) {
      showMenu('Type your name ${player}');
      name = stdin.readLineSync();
      clearScreen();
    }
    if (name != null) {
      return name;
    } else {
      return player;
    }
  }

  static bool firstMove() {
    String? answer = "";
    while (answer != null &&
        (answer.toLowerCase() != 'y' && answer.toLowerCase() != 'n')) {
      showMenu('Do you want to make a first move?(y/n)');
      answer = stdin.readLineSync();
    }
    if (answer == 'y') {
      return true;
    }
    return false;
  }

  static bool piecePicker() {
    int piece = 0;
    while (!(1 <= piece && piece <= 2)) {
      showMenu('Choose your piece\n1.X\n2.O');
      try {
        piece = int.parse(stdin.readLineSync() ?? '');
      } catch (exception) {
        piece = 0;
      }
    }
    return piece == 1 ? true : false;
  }

  static void showMenu(String question) {
    clearScreen();
    stdout.writeln('Welcome to the Gobblets Game!');
    stdout.writeln('*****************************');
    stdout.writeln('Menu');
    stdout.writeln(question);
  }

  static void clearScreen() {
    print("\x1B[2J\x1B[0;0H");
  }
}
