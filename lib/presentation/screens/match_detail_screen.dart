import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/match_entity.dart';

class MatchDetailScreen extends StatelessWidget {
  final MatchEntity match;

  const MatchDetailScreen({super.key, required this.match});

  String formatDate(String utcDate) {
    final dateTime = DateTime.parse(utcDate);
    return DateFormat('MMM d, yyyy - HH:mm').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${match.homeTeamName} vs ${match.awayTeamName}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Competition: ${match.competitionName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Date: ${formatDate(match.utcDate)}'),
            const SizedBox(height: 8),
            Text('Status: ${match.status}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(match.homeTeamCrest),
                      ),
                      const SizedBox(height: 8),
                      Text(match.homeTeamName, textAlign: TextAlign.center),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${match.homeScore ?? '-'} : ${match.awayScore ?? '-'}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(match.awayTeamCrest),
                      ),
                      const SizedBox(height: 8),
                      Text(match.awayTeamName, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/image.png'),
            const SizedBox(height: 80), // để không bị che bởi bottom buttons
          ],
        ),
      ),
      bottomNavigationBar:
          match.status == "TIMED"
              ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 50),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Match result prediction'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Icon(Icons.notifications_active),
                      ),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
