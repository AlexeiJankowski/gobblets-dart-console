import './models/player.dart';
import 'move_control.dart';

class StartGame {
  static void start(List<Player> players) {
    //empty uniqueNumbersField
    List<String> fieldSequence = List.filled(9, '   ');
    bool won = false;

    Player player1 = players.where((p) => p.firstMove == true).first;
    Player player2 = players.where((p) => p.firstMove == false).first;

    MoveControl moveControl = MoveControl();

    while (!won) {
      if (player1.game.madeAMove == false) {
        moveControl.chooseAction(player1, fieldSequence);
        player1.game.madeAMove = !player1.game.madeAMove;
      } else {
        moveControl.chooseAction(player2, fieldSequence);
        player1.game.madeAMove = !player1.game.madeAMove;
      }

      if (player1.game.won == true || player2.game.won == true) {
        won = true;
      }
    }
  }
}
