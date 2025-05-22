import 'dart:convert';
import 'package:fifaschedule/domain/entities/standing_entity.dart';
import 'package:http/http.dart' as http;

class StandingsRemoteDataSource {
  final String apiKey = '4a8b4bd9034842a4802010e85143f016';

  Future<List<StandingEntity>> getStandings(String competitionId) async {
    final response = await http.get(
      Uri.parse('https://api.football-data.org/v4/competitions/$competitionId/standings'),
      headers: {'X-Auth-Token': apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['standings'][0]['table'] as List<dynamic>).map((team) {
        return StandingEntity(
          position: team['position'],
          teamName: team['team']['name'],
          teamCrest: team['team']['crest'] ?? 'https://via.placeholder.com/40',
          points: team['points'],
          playedGames: team['playedGames'],
          won: team['won'],
          draw: team['draw'],
          lost: team['lost'],
          goalDifference: team['goalDifference'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load standings: ${response.statusCode}');
    }
  }
}