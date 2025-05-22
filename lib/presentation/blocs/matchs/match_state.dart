import 'package:fifaschedule/domain/entities/match_entity.dart';

abstract class MatchState {}

class MatchesInitial extends MatchState {}

class MatchesLoading extends MatchState {}

class MatchesLoaded extends MatchState {
  final List<MatchEntity> allMatches;
  final List<MatchEntity> premierLeagueMatches;
  final List<MatchEntity> laLigaMatches;

  MatchesLoaded({
    required this.allMatches,
    required this.premierLeagueMatches,
    required this.laLigaMatches,
  });
}

class MatchesEmpty extends MatchState {}

class MatchesError extends MatchState {
  final String message;

  MatchesError(this.message);
}