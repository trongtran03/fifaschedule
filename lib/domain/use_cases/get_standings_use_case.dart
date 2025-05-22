

import 'package:fifaschedule/domain/entities/standing_entity.dart';
import 'package:fifaschedule/domain/repositories/standings_repository.dart';

class GetStandingsUseCase {
  final StandingsRepository repository;

  GetStandingsUseCase(this.repository);

  Future<Map<String, List<StandingEntity>>> call() async {
    final plStandings = await repository.getPremierLeagueStandings();
    final llStandings = await repository.getLaLigaStandings();
    return {
      'premierLeague': plStandings,
      'laLiga': llStandings,
    };
  }
}