import 'package:finding_jura/components/player.dart';
import 'package:finding_jura/game.dart';
import 'package:flame/components.dart';

class FindJuraWorld extends World with HasGameRef<FindJuraGame> {
  late final Player player;

  @override
  Future<void> onLoad() async {
    player = Player();

    addAll([player]);
  }
}

// Cheveux 696057
// 332a23
//
// f2e5d6
