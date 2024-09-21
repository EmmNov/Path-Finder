import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final int x;
  final int y;

  const Position(this.x, this.y);

  static const empty = Position(0, 0);

  @override
  List<Object?> get props => [x, y];
  @override
  String toString() => '($x,$y)';
}
