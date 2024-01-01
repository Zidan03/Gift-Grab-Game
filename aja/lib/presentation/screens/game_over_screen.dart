import 'dart:ffi';

import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:aja/presentation/widgets/screen_background_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GameOverScreen extends ConsumerWidget {
  final GiftGrabGame gameRef;

  const GameOverScreen({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late FirebaseAuth _auth;
    late Stream<User?> _authStateChanges;
    final _user = Rxn<User>();

    final theme = Theme.of(context);
    return ScreenBackgroundWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'Times Up',
                style: theme.textTheme.displayLarge!.copyWith(
                  fontSize: Globals.isTablet
                      ? theme.textTheme.displayLarge!.fontSize! * 2
                      : theme.textTheme.displayLarge!.fontSize,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'Score: ${gameRef.score}',
                style: theme.textTheme.displayLarge!.copyWith(
                  fontSize: Globals.isTablet
                      ? theme.textTheme.displayLarge!.fontSize! * 3
                      : theme.textTheme.displayLarge!.fontSize,
                ),
              ),
            ),
            SizedBox(
              width: Globals.isTablet ? 400 : 200,
              height: Globals.isTablet ? 100 : 50,
              child: ElevatedButton(
                onPressed: () {
                  _auth = FirebaseAuth.instance;
                  _authStateChanges = _auth.authStateChanges();
                  _authStateChanges.listen((User? user) {
                    _user.value = user;
                    CollectionReference CollRef = FirebaseFirestore.instance
                        .collection('Score');
                    CollRef.add({
                      'Score': '${gameRef.score}',
                      'Username': user?.email
                    });
                    gameRef.removeMenu(menu: Screens.gameOver);
                    gameRef.resumeEngine();
                    gameRef.reset();
                  });
                },
                child: Text(
                  'Play Again?',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 50 : 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Globals.isTablet ? 400 : 200,
              height: Globals.isTablet ? 100 : 50,
              child: ElevatedButton(
                onPressed: () {
                  _auth = FirebaseAuth.instance;
                  _authStateChanges = _auth.authStateChanges();
                  _authStateChanges.listen((User? user) {
                    _user.value = user;
                    CollectionReference CollRef = FirebaseFirestore.instance
                        .collection('Score');
                    CollRef.add({
                      'Score': '${gameRef.score}',
                      'Username': user?.email
                    });
                    gameRef.removeMenu(menu: Screens.gameOver);
                    gameRef.reset();
                    gameRef.addMenu(menu: Screens.main);
                  });
                },
                child: Text(
                  'Main Menu',
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
