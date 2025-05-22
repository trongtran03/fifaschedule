
import 'package:fifaschedule/domain/entities/standing_entity.dart';

abstract class StandingsRepository {
  Future<List<StandingEntity>> getPremierLeagueStandings();
  Future<List<StandingEntity>> getLaLigaStandings();
}