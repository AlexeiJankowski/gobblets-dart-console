import 'menu.dart';
import './models/player.dart';
import 'start_game.dart';

void main(List<String> arguments) {
  Menu menu = Menu();
  List<Player> players = menu.playerBuilder();
  StartGame.start(players);
}
