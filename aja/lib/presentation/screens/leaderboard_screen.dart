import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../games/gift_grab_game.dart';

class LeaderboardScreen extends StatelessWidget {
  final GiftGrabGame gameRef;

  const LeaderboardScreen({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Navigasi ke layar leaderboard
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TopScoresList()),
            );
          },
          child: Text('Show Leaderboard'),
        ),
      ),
    );
  }
}

class TopScoresList extends StatelessWidget {
  Future<List<Map<String, dynamic>>> getTopScores() async {
    try {
      // Mengambil data dari koleksi 'Score', diurutkan berdasarkan 'Score' secara descending, dan dibatasi sebanyak 10.
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Score')
          .orderBy('Score', descending: true)
          .limit(10)
          .get();

      // Mengonversi hasil query menjadi daftar peta dengan mengubah 'Score' menjadi int.
      List<Map<String, dynamic>> topScores = querySnapshot.docs.map((doc) {
        return {
          'Username': doc['Username'],
          'Score': int.parse(doc['Score'] ?? '0'), // Ubah score dari string ke int
        };
      }).toList();

      // Mengurutkan berdasarkan score dari tertinggi ke rendah
      topScores.sort((a, b) => b['Score'].compareTo(a['Score']));

      return topScores;
    } catch (e) {
      // Handle error jika terjadi.
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top 10 Scores'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getTopScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> topScores = snapshot.data ?? [];
            return ListView.builder(
              itemCount: topScores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Username: ${topScores[index]['Username']}'),
                  subtitle: Text('Score: ${topScores[index]['Score']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
