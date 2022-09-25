import 'field.dart';
import 'game.dart';

class Player {
  Player({required this.name, required this.piece, required this.firstMove});

  String name;
  final bool piece;
  final bool firstMove;
  // bool madeAMove = false; //game.madeAMove
  // bool won = false; //Game.won

  Field field = Field();
  Game game = Game();

  // int currentPieceSize = 0; //Game.currentPieceSize

  int smallPieces = 2;
  int mediumPieces = 2;
  int bigPieces = 2;
}
