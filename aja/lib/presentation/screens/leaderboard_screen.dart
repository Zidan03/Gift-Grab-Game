import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../games/gift_grab_game.dart';

class LeaderboardScreen extends StatelessWidget {
  final GiftGrabGame gameRef;

  const LeaderboardScreen({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: TopScoresList(topScores: [],).getTopScores(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return TopScoresList(topScores: snapshot.data ?? []);
            }
          },
        ),
      ),
    );
  }
}

class TopScoresList extends StatelessWidget {
  final List<Map<String, dynamic>> topScores;

  TopScoresList({required this.topScores});

  Future<List<Map<String, dynamic>>> getTopScores() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Score')
          .orderBy('Score', descending: true)
          .limit(10)
          .get();

      List<Map<String, dynamic>> topScores = querySnapshot.docs.map((doc) {
        return {
          'Username': doc['Username'],
          'Score': int.parse(doc['Score'] ?? '0'),
        };
      }).toList();

      topScores.sort((a, b) => b['Score'].compareTo(a['Score']));

      return topScores;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top 10 Scores',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: ListView.builder(
        itemCount: topScores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Username: ${topScores[index]['Username']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Score: ${topScores[index]['Score']}',
              style: TextStyle(fontSize: 16.0),
            ),
          );
        },
      ),
    );
  }
}
