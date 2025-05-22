
import 'package:fifaschedule/domain/entities/match_entity.dart';

abstract class MatchRepository {
  Future<List<MatchEntity>> getMatches(String dateFrom, String dateTo);
}