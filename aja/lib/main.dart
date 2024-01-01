import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:aja/presentation/screens/game_over_screen.dart';
import 'package:aja/presentation/screens/leaderboard_screen.dart';
import 'package:aja/presentation/screens/main_menu_screen.dart';
import 'package:aja/util/app_themes.dart';
import 'package:aja/util/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flame/game.dart';
import 'presentation/screens/login_screen.dart';

GiftGrabGame _giftGrabGame = GiftGrabGame();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Globals.isTablet = DeviceInformation.isTablet();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: GameWidget(
          initialActiveOverlays: [Screens.login.name],
          game: _giftGrabGame,
          overlayBuilderMap: {
            Screens.gameOver.name:
                (BuildContext context, GiftGrabGame gameRef) =>
                    GameOverScreen(gameRef: gameRef),
            Screens.main.name: (BuildContext context, GiftGrabGame gameRef) =>
                MainMenuScreen(gameRef: gameRef),
            Screens.login.name: (BuildContext context, GiftGrabGame gameRef) =>
                LoginScreen(gameRef: gameRef),
            Screens.leaderboard.name:
                (BuildContext context, GiftGrabGame gameRef) =>
                    LeaderboardScreen(gameRef: gameRef),
          },
        ),
      ),
    ),
  );
}
