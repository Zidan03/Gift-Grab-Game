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
    ); // Access the widget property of the FlameGame
  }
}

class GiftGrabGame extends FlameGame with DragCallbacks, HasCollisionDetection {
  /// The Santa character who collects the gifts.
  final SantaComponent _santaComponent = SantaComponent(joystick: joystick);

  /// Background of snow landscape.
  final BackgroundComponent _backgroundComponent = BackgroundComponent();

  /// The first gift to collect.
  final GiftComponent _giftComponent = GiftComponent();

  /// Flame powerup.
  final FlameComponent _flameComponent = FlameComponent(
    startPosition: Vector2(200, 200),
  );

  /// Number of presents Santa has grabbed.
  int score = 0;

  /// Total seconds for each game.
  static int _remainingTime = Globals.gameTimeLimit;

  int _flameRemainingTime = Globals.flameTimeLimit;

  /// Timer for game countdown.
  late Timer gameTimer;

  late Timer flameTimer;

  /// Text UI component for score.
  late TextComponent _scoreText;

  /// Text UI component for timer.
  late TextComponent _timerText;

  /// Text UI component for flame counter.
  late TextComponent flameTimerText;

  /// Time when the flame appears.
  static int _flameTimeAppearance = _getRandomInt(
    min: 10,
    max: _remainingTime,
  );

  /// Time when the flame appears.
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


    // Configure countdown timer.
    gameTimer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_remainingTime == 0) {
          // Pause the game.
          pauseEngine();
          // Display game over menu.
          addMenu(menu: Screens.gameOver);
        } else if (_remainingTime == _flameTimeAppearance) {
          // Display the flame powerup.
          add(_flameComponent);
        } else if (_remainingTime == _cookieTimeAppearance) {
          // Display the cookie powerup.
          add(CookieComponent());
        }

        // Decrement time by one second.
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

    // Preload audio files.
    await FlameAudio.audioCache.loadAll(
      [
        Globals.freezeSound,
        Globals.itemGrabSound,
        Globals.flameSound,
      ],
    );

    // Add background.
    add(_backgroundComponent);

    // Add initial gift.
    add(_giftComponent);

    // Add ice blocks.
    add(IceComponent(startPosition: Vector2(200, 200)));
    add(IceComponent(startPosition: Vector2(size.x - 200, size.y - 200)));

    // Add santa.
    add(_santaComponent);

    // Add joystick.
    add(joystick);

    // Add ScreenHitBox for boundries for ice blocks.
    add(ScreenHitbox());

    // Configure TextComponent
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

    // Add Score TextComponent.
    add(_scoreText);

    // Configure TextComponent
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

    // Add Score TextComponent.
    add(_timerText);

    // Configure TextComponent
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

  /// Reset score and remaining time to default values.
  void reset() {
    // Scores
    score = 0;

    // Timers
    _remainingTime = Globals.gameTimeLimit;
    _flameRemainingTime = Globals.flameTimeLimit;

    // Time Appearences
    _flameTimeAppearance = _getRandomInt(
      min: 10,
      max: _remainingTime,
    );
    _cookieTimeAppearance = _getRandomInt(
      min: 10,
      max: _remainingTime,
    );

    // Sprites
    _flameComponent.removeFromParent();

    // Texts
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
      addIceComponents(0);  // Pada level 1, tambahkan 2 IceComponent
      break;
    case 2:
      addIceComponents(1);  // Pada level 2, tambahkan 3 IceComponent
      break;
    case 3:
      addIceComponents(2);  // Pada level 3, tambahkan 4 IceComponent
      break;
    default:
      // Set logika default atau level lainnya
  }
}

void addIceComponents(int count) {
  for (int i = 0; i < count; i++) {
    add(IceComponent(startPosition: Vector2(200, 200)));
  }
}


}
