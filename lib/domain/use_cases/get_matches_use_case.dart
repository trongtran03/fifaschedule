
import 'package:fifaschedule/domain/entities/match_entity.dart';
import 'package:fifaschedule/domain/repositories/match_repository.dart';

class GetMatchesUseCase {
  final MatchRepository repository;

  GetMatchesUseCase(this.repository);

  Future<List<MatchEntity>> call(String dateFrom, String dateTo) async {
    return await repository.getMatches(dateFrom, dateTo);
  }
}