import 'dart:convert';
import 'package:fifaschedule/domain/entities/match_entity.dart';
import 'package:http/http.dart' as http;

class MatchRemoteDataSource {
  final String apiKey = '4a8b4bd9034842a4802010e85143f016';

  Future<List<MatchEntity>> getMatches(String dateFrom, String dateTo) async {
    final response = await http.get(
      Uri.parse('https://api.football-data.org/v4/matches?dateFrom=$dateFrom&dateTo=$dateTo'),
      headers: {'X-Auth-Token': apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final matches = (data['matches'] as List<dynamic>).map((match) {
        return MatchEntity(
          id: match['id'],
          competitionName: match['competition']['name'],
          homeTeamName: match['homeTeam']['shortName'],
          awayTeamName: match['awayTeam']['shortName'],
          homeTeamCrest: match['homeTeam']['crest'] ?? 'https://via.placeholder.com/60',
          awayTeamCrest: match['awayTeam']['crest'] ?? 'https://via.placeholder.com/60',
          status: match['status'],
          utcDate: match['utcDate'],
          homeScore: match['score']['fullTime']['home'],
          awayScore: match['score']['fullTime']['away'],
          competitionCode: match['competition']['code'],
        );
      }).toList();

      matches.sort((a, b) => DateTime.parse(b.utcDate).compareTo(DateTime.parse(a.utcDate)));
      return matches;
    } else {
      throw Exception('Failed to load matches: ${response.statusCode}');
    }
  }
}