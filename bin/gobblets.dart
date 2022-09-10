import 'package:gobblets/gobblets.dart' as gobblets;
import 'menu.dart';
import 'player.dart';
import 'startGame.dart';
import 'wonSequences.dart';

void main(List<String> arguments) {
  List<Player> players = Menu.playerBuilder();
  StartGame.gameRunner(players);
}
