import 'menu.dart';
import './models/player.dart';
import 'start_game.dart';

void main(List<String> arguments) {
  List<Player> players = Menu.playerBuilder();
  StartGame.start(players);
}
