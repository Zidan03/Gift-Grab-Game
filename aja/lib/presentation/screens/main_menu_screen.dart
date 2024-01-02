import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:aja/presentation/screens/level_screen.dart';
import 'package:aja/presentation/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';
import 'leaderboard_screen.dart';

class MainMenuScreen extends StatelessWidget {
  final GiftGrabGame gameRef;

  const MainMenuScreen({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonWidth = Globals.isTablet ? 450.0 : 250.0;
    final buttonHeight = Globals.isTablet ? 120.0 : 70.0;

    return ScreenBackgroundWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'Gift Grab',
                style: theme.textTheme.displayLarge!.copyWith(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LevelScreen(
                        gameRef: gameRef,
                        level: 0,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Play',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 30 : 22,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardScreen(gameRef: gameRef),
                    ),
                  );
                },
                child: Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 30 : 22,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  gameRef.addMenu(menu: Screens.login);
                  gameRef.removeMenu(menu: Screens.main);
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 30 : 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
