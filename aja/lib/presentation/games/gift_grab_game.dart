import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/presentation/components/background_component.dart';
import 'package:aja/presentation/components/cookie_component.dart';
import 'package:aja/presentation/components/flame_component.dart';
import 'package:aja/presentation/components/gift_component.dart';
import 'package:aja/presentation/components/ice_component.dart';
import 'package:aja/presentation/components/santa_component.dart';
import 'package:aja/presentation/inputs/joystick.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GiftGrabGameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GameWidget<GiftGrabGame>(
          game: GiftGrabGame(),
        ),
      ),
    );
  }
}

class GiftGrabGame extends FlameGame with DragCallbacks, HasCollisionDetection {
  final SantaComponent _santaComponent = SantaComponent(joystick: joystick);
  final BackgroundComponent _backgroundComponent = BackgroundComponent();
  final GiftComponent _giftComponent = GiftComponent();
  final FlameComponent _flameComponent = FlameComponent(
    startPosition: Vector2(200, 200),
  );

  int score = 0;

  static int _remainingTime = Globals.gameTimeLimit;
  int _flameRemainingTime = Globals.flameTimeLimit;
  late Timer gameTimer;
  late Timer flameTimer;
  late TextComponent _scoreText;
  late TextComponent _timerText;
  late TextComponent flameTimerText;

  static int _flameTimeAppearance = _getRandomInt(
    min: 10,
    max: _remainingTime,
  );

  static int _cookieTimeAppearance = _getRandomInt(
    min: 10,
    max: _remainingTime,
  );

  var gameRef;

  num? get currentLevel => null;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    pauseEngine();
    gameTimer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_remainingTime == 0) {
          pauseEngine();
          addMenu(menu: Screens.gameOver);
        } else if (_remainingTime == _flameTimeAppearance) {
          add(_flameComponent);
        } else if (_remainingTime == _cookieTimeAppearance) {
          add(CookieComponent());
        }
        _remainingTime -= 1;
      },
    );

    flameTimer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_flameRemainingTime == 0) {
          _santaComponent.unflameSanta();
          flameTimerText.removeFromParent();
        } else {
          _flameRemainingTime -= 1;
        }
      },
    );

    await FlameAudio.audioCache.loadAll(
      [
        Globals.freezeSound,
        Globals.itemGrabSound,
        Globals.flameSound,
      ],
    );

    add(_backgroundComponent);
    add(_giftComponent);
    add(IceComponent(startPosition: Vector2(200, 200)));
    add(IceComponent(startPosition: Vector2(size.x - 200, size.y - 200)));
    add(_santaComponent);
    add(joystick);
    add(ScreenHitbox());

    _scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(40, 50),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: Globals.isTablet ? 50 : 25,
        ),
      ),
    );

    add(_scoreText);
    _timerText = TextComponent(
      text: 'Time: $score',
      position: Vector2(size.x - 40, 50),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: Globals.isTablet ? 50 : 25,
        ),
      ),
    );

    add(_timerText);

    flameTimerText = TextComponent(
      text: 'Flame Time: $_flameRemainingTime',
      position: Vector2(size.x - 40, size.y - 100),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.black.color,
          fontSize: Globals.isTablet ? 50 : 25,
        ),
      ),
    );

    gameTimer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameTimer.update(dt);
    if (_santaComponent.isFlamed) {
      flameTimer.update(dt);
      flameTimerText.text = 'Flame Time: $_flameRemainingTime';
    }
    _scoreText.text = 'Score: $score';
    _timerText.text = 'Time: $_remainingTime secs';
  }

  void reset() {
    score = 0;
    _remainingTime = Globals.gameTimeLimit;
    _flameRemainingTime = Globals.flameTimeLimit;
    _flameTimeAppearance = _getRandomInt(
      min: 10,
      max: _remainingTime,
    );
    _cookieTimeAppearance = _getRandomInt(
      min: 10,
      max: _remainingTime,
    );
    _flameComponent.removeFromParent();
    flameTimerText.removeFromParent();
  }

  void addMenu({
    required Screens menu,
  }) {
    overlays.add(menu.name);
  }

  void removeMenu({
    required Screens menu,
  }) {
    overlays.remove(menu.name);
  }

  static int _getRandomInt({
    required int min,
    required int max,
  }) {
    Random rng = Random();
    return rng.nextInt(max - min) + min;
  }

  void setLevel(int level) {
    switch (level) {
      case 1:
        addIceComponents(0);
        break;
      case 2:
        addIceComponents(1);
        break;
      case 3:
        addIceComponents(2);
        break;
      default:
    }
  }

  void addIceComponents(int count) {
    for (int i = 0; i < count; i++) {
      add(IceComponent(startPosition: Vector2(200, 200)));
    }
  }
}
