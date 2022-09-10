import 'field.dart';

class Player {
  Player({required this.name, required this.piece, required this.firstMove});

  String name;
  final bool piece;
  final bool firstMove;
  bool madeAMove = false;
  bool won = false;

  Field field = Field();

  int currentPieceSize = 0;

  int smallPieces = 2;
  int mediumPieces = 2;
  int bigPieces = 2;
}
