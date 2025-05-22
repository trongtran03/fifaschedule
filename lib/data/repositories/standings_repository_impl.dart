
import 'package:fifaschedule/data/data_sources/standings_remote_data_source.dart';
import 'package:fifaschedule/domain/entities/standing_entity.dart';
import 'package:fifaschedule/domain/repositories/standings_repository.dart';

class StandingsRepositoryImpl implements StandingsRepository {
  final StandingsRemoteDataSource remoteDataSource;

  StandingsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<StandingEntity>> getPremierLeagueStandings() async {
    try {
      return await remoteDataSource.getStandings('2021');
    } catch (e) {
      throw Exception('Failed to fetch Premier League standings: $e');
    }
  }

  @override
  Future<List<StandingEntity>> getLaLigaStandings() async {
    try {
      return await remoteDataSource.getStandings('2014');
    } catch (e) {
      throw Exception('Failed to fetch La Liga standings: $e');
    }
  }
}