import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:aja/presentation/widgets/leaderboard_record_widget.dart';
import 'package:aja/presentation/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardScreen extends ConsumerWidget {
  final GiftGrabGame gameRef;
  const LeaderboardScreen({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ScreenBackgroundWidget(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'Leaderboard',
                style: theme.textTheme.displayLarge!.copyWith(
                  fontSize: Globals.isTablet
                      ? theme.textTheme.displayLarge!.fontSize! * 2
                      : theme.textTheme.displayLarge!.fontSize,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List>(
                // future: nakamaProvider.listLeaderboardRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('None');
                  } else {
                    List leaderboardRecords = snapshot.data!;

                    if (leaderboardRecords.isEmpty) {
                      return Center(
                        child: Text('No records for this week yet...',
                            style: theme.textTheme.displayLarge),
                      );
                    }

                    return ListView.builder(
                      itemCount: leaderboardRecords.length,
                      itemBuilder: ((_, index) => LeaderboardRecordWidget(
                          leaderboardRecord: leaderboardRecords[index])),
                    );
                  }
                }, future: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: Globals.isTablet ? 400 : 200,
                height: Globals.isTablet ? 100 : 50,
                child: ElevatedButton(
                  onPressed: () {
                    gameRef.addMenu(menu: Screens.main);
                    gameRef.removeMenu(menu: Screens.leaderboard);
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontSize: Globals.isTablet ? 50 : 25,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
