

import 'package:fifaschedule/data/data_sources/match_remote_data_source.dart';
import 'package:fifaschedule/domain/entities/match_entity.dart';
import 'package:fifaschedule/domain/repositories/match_repository.dart';

class MatchRepositoryImpl implements MatchRepository {
  final MatchRemoteDataSource remoteDataSource;

  MatchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MatchEntity>> getMatches(String dateFrom, String dateTo) async {
    try {
      return await remoteDataSource.getMatches(dateFrom, dateTo);
    } catch (e) {
      throw Exception('Failed to fetch matches: $e');
    }
  }
}