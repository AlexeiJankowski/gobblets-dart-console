import 'dart:io';

import './models/player.dart';
import 'helper.dart';

class Menu {
  List<Player> playerBuilder() {
    List<Player> players = List.empty(growable: true);

    Player player1 = Player(
        name: playerName('player 1'),
        piece: piecePicker(),
        firstMove: firstMove());
    Player player2 = Player(
        name: playerName('player 2'),
        piece: !player1.piece,
        firstMove: !player1.firstMove);

    players.add(player1);
    players.add(player2);

    return players;
  }

  String playerName(String player) {
    String name = player;
    showMenu('Type your name $player');
    name = stdin.readLineSync() ?? '';
    Helper.clearScreen();
    if (name.isEmpty || name == '') {
      return player;
    } else {
      return name;
    }
  }

  bool firstMove() {
    String? answer = '';
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

  bool piecePicker() {
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

  showMenu(String question) {
    Helper.clearScreen();
    stdout.writeln('Welcome to the Gobblets Game!');
    stdout.writeln('*****************************');
    stdout.writeln('Menu');
    stdout.writeln(question);
  }
}
