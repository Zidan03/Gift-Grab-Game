import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';import 'package:aja/presentation/screens/level_screen.dart';

import 'package:aja/presentation/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  final GiftGrabGame gameRef;
  const MainMenuScreen({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  fontSize: Globals.isTablet
                      ? theme.textTheme.displayLarge!.fontSize! * 2
                      : theme.textTheme.displayLarge!.fontSize,
                ),
              ),
            ),
            // Tombol Play
            SizedBox(
              width: Globals.isTablet ? 400 : 200,
              height: Globals.isTablet ? 100 : 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LevelScreen(gameRef: gameRef, level: 0,)),
                  );
                },
                child: Text(
                  'Play',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 50 : 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Tombol Leaderboard
            SizedBox(
              width: Globals.isTablet ? 400 : 250,
              height: Globals.isTablet ? 100 : 50,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.addMenu(menu: Screens.leaderboard);
                  gameRef.removeMenu(menu: Screens.main);
                },
                child: Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 50 : 25,
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // // Tombol Level dengan nama Level1
            // SizedBox(
            //   width: Globals.isTablet ? 400 : 200,
            //   height: Globals.isTablet ? 100 : 50,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Tindakan yang ingin dilakukan ketika tombol Level ditekan
            //       // Misalnya, pindah ke layar Level1
            //       Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LevelScreen(gameRef: gameRef, level: 0,)),
            //       );

            //     },
            //     child: Text(
            //       'Level',
            //       style: TextStyle(
            //         fontSize: Globals.isTablet ? 50 : 25,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            // Tombol Back
            SizedBox(
              width: Globals.isTablet ? 400 : 200,
              height: Globals.isTablet ? 100 : 50,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.addMenu(menu: Screens.login);
                  gameRef.removeMenu(menu: Screens.main);
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 50 : 25,
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