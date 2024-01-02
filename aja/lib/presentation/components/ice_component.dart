import 'dart:ui';

import 'package:aja/data/constants/globals.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

class IceComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = Globals.isTablet ? 200.0 : 100.0;
  late Vector2 _velocity;
  double speed = Globals.isTablet ? 300 : 150;
  final double degree = math.pi / 180;
  final Vector2 startPosition;

  IceComponent({required this.startPosition});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.iceSprite);
    position = startPosition;
    final double spawnAngle = _getSpawnAngle();
    final double vx = math.cos(spawnAngle * degree) * speed;
    final double vy = math.sin(spawnAngle * degree) * speed;
    _velocity = Vector2(vx, vy);
    width = _spriteHeight;
    height = _spriteHeight;
    anchor = Anchor.center;
    add(CircleHitbox()..radius = 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;
      if (collisionPoint.x <= 0) {
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.x >= gameRef.size.x - width) {
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.y <= 0) {
        _velocity.y = -_velocity.y;
      }
      if (collisionPoint.y >= gameRef.size.y - height) {
        _velocity.y = -_velocity.y;
      }
    }
  }

  double _getSpawnAngle() {
    final random = math.Random().nextDouble();
    final spawnAngle = lerpDouble(0, 360, random)!;
    return spawnAngle;
  }
}
