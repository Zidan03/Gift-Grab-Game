import 'package:flutter/material.dart';
import 'package:nakama/api.dart';

class LeaderboardRecordWidget extends StatelessWidget {
  final LeaderboardRecord leaderboardRecord;

  static const TextStyle _style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 21,
    color: Colors.white,
  );

  const LeaderboardRecordWidget({
    required this.leaderboardRecord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          '${leaderboardRecord.rank}',
          style: _style,
        ),
      ),
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        height: 30,
        child: Center(
          child: Text(
            leaderboardRecord.username.value,
            style: _style.copyWith(color: Colors.black),
          ),
        ),
      ),
      trailing: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          '${leaderboardRecord.score}',
          style: _style,
        ),
      ),
    );
  }
}
