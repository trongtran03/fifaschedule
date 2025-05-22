import 'package:fifaschedule/domain/entities/standing_entity.dart';

abstract class StandingsState {}

class StandingsInitial extends StandingsState {}

class StandingsLoading extends StandingsState {}

class StandingsLoaded extends StandingsState {
  final List<StandingEntity> premierLeagueTable;
  final List<StandingEntity> laLigaTable;

  StandingsLoaded({
    required this.premierLeagueTable,
    required this.laLigaTable,
  });
}

class StandingsEmpty extends StandingsState {}

class StandingsError extends StandingsState {
  final String message;

  StandingsError(this.message);
}