import 'package:aja/data/constants/globals.dart';
import 'package:aja/presentation/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:aja/presentation/games/gift_grab_game.dart'; // Sesuaikan dengan path yang benar
import 'package:aja/data/constants/screens.dart';

class LevelScreen extends StatelessWidget {
  final GiftGrabGame gameRef;
  final int level; // Tambahkan level

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
                style: theme.textTheme.displayLarge!.copyWith(
                  fontSize: Globals.isTablet
                      ? theme.textTheme.displayLarge!.fontSize! * 2
                      : theme.textTheme.displayLarge!.fontSize,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLevelButton(context, 1),
                buildLevelButton(context, 2),
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
    //   appBar: AppBar(
    //     title: const Text('Pilih Level'),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         buildLevelButton(context, 1),
    //         buildLevelButton(context, 2),
    //         buildLevelButton(context, 3),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget buildLevelButton(BuildContext context, int level) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          gameRef.removeMenu(menu: Screens.main);
          gameRef.resumeEngine();
          Navigator.pop(context);
          gameRef.setLevel(level); // Kirim level ke GiftGrabGame
        },
        child: Text(
          'Level $level',
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
