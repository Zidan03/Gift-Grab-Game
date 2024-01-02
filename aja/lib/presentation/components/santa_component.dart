import 'package:aja/data/constants/globals.dart';
import 'package:aja/presentation/components/cookie_component.dart';
import 'package:aja/presentation/components/ice_component.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'flame_component.dart';

enum MovementState {
  idle,
  slideLeft,
  slideRight,
  frozen,
}

class SantaComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = Globals.isTablet ? 200.0 : 100;

  static final double _originalSpeed = Globals.isTablet ? 500.0 : 250.0;
  static double _speed = _originalSpeed;
  final JoystickComponent joystick;

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  bool isFrozen = false;
  bool isFlamed = false;

  final Timer _frozenCountdown = Timer(Globals.frozenTimeLimit.toDouble());
  final Timer _cookieCountdown = Timer(Globals.cookieTimeLimit.toDouble());

  SantaComponent({required this.joystick});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final Sprite santaIdle = await gameRef.loadSprite(Globals.santaIdle);
    final Sprite santaSlideLeft =
        await gameRef.loadSprite(Globals.santaSlideLeftSprite);
    final Sprite santaSlideRight =
        await gameRef.loadSprite(Globals.santaSlideRightSprite);
    final Sprite santaFrozen = await gameRef.loadSprite(Globals.santaFrozen);

    sprites = {
      MovementState.idle: santaIdle,
      MovementState.slideLeft: santaSlideLeft,
      MovementState.slideRight: santaSlideRight,
      MovementState.frozen: santaFrozen,
    };

    _rightBound = gameRef.size.x - 45;
    _leftBound = 0 + 45;
    _upBound = 0 + 55;
    _downBound = gameRef.size.y - 55;
    position = gameRef.size / 2;
    width = _spriteHeight * 1.42;
    height = _spriteHeight;
    anchor = Anchor.center;
    current = MovementState.idle;
    add(CircleHitbox()..radius = 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isFrozen) {
      if (joystick.direction == JoystickDirection.idle) {
        current = MovementState.idle;
        return;
      }
      if (x >= _rightBound) {
        x = _rightBound - 1;
      }
      if (x <= _leftBound) {
        x = _leftBound + 1;
      }
      if (y >= _downBound) {
        y = _downBound - 1;
      }
      if (y <= _upBound) {
        y = _upBound + 1;
      }
      bool moveLeft = joystick.relativeDelta[0] < 0;
      if (moveLeft) {
        current = MovementState.slideLeft;
      } else {
        current = MovementState.slideRight;
      }
      _cookieCountdown.update(dt);
      if (_cookieCountdown.finished) {
        _resetSpeed();
      }
      position.add(joystick.relativeDelta * _speed * dt);
    } else {
      _frozenCountdown.update(dt);
      if (_frozenCountdown.finished) {
        _unfreezeSanta();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is IceComponent) {
      if (!isFlamed) {
        _freezeSanta();
      }
    }
    if (other is FlameComponent) {
      flameSanta();
    }
    if (other is CookieComponent) {
      _increaseSpeed();
    }
  }

  void _increaseSpeed() {
    FlameAudio.play(Globals.itemGrabSound);
    _speed *= 2;
    _cookieCountdown.start();
  }

  void _resetSpeed() {
    _speed = _originalSpeed;
  }

  void flameSanta() {
    if (!isFrozen) {
      isFlamed = true;
      FlameAudio.play(Globals.flameSound);
      gameRef.add(gameRef.flameTimerText);
      gameRef.flameTimer.start();
    }
  }

  void unflameSanta() {
    isFlamed = false;
  }

  void _freezeSanta() {
    if (!isFrozen) {
      isFrozen = true;
      FlameAudio.play(Globals.freezeSound);
      current = MovementState.frozen;
      _frozenCountdown.start();
    }
  }

  void _unfreezeSanta() {
    isFrozen = false;
    current = MovementState.idle;
  }
}
