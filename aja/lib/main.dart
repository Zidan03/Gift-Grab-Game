import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/firebase_options.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:aja/presentation/screens/game_over_screen.dart';
import 'package:aja/presentation/screens/leaderboard_screen.dart';
import 'package:aja/presentation/screens/main_menu_screen.dart';
import 'package:aja/util/app_themes.dart';
import 'package:aja/util/device_information.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/auth/auth_controllers.dart';
import 'presentation/screens/login_screen.dart';

GiftGrabGame _giftGrabGame = GiftGrabGame();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  Globals.isTablet = DeviceInformation.isTablet();
  AuthController authController = AuthController();

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
                LoginScreen(gameRef: gameRef, authController: authController),
            Screens.leaderboard.name:
                (BuildContext context, GiftGrabGame gameRef) =>
                    LeaderboardScreen(gameRef: gameRef),
          },
        ),
      ),
    ),
  );
}
