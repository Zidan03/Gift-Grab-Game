import 'package:aja/presentation/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:aja/data/constants/screens.dart';

class LevelScreen extends StatelessWidget {
  final GiftGrabGame gameRef;
  final int level;

  const LevelScreen({Key? key, required this.gameRef, required this.level})
      : super(key: key);

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
                'Pilih Level',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLevelButton(context, 1),
                SizedBox(height: 16),
                buildLevelButton(context, 2),
                SizedBox(height: 16),
                buildLevelButton(context, 3),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLevelButton(BuildContext context, int level) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          gameRef.removeMenu(menu: Screens.main);
          gameRef.resumeEngine();
          Navigator.pop(context);
          gameRef.setLevel(level);
        },
        child: Text(
          'Level $level',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
