import 'package:aja/data/constants/globals.dart';
import 'package:flutter/material.dart';

class ScreenBackgroundWidget extends StatelessWidget {
  const ScreenBackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/${Globals.backgroundSprite}"),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
