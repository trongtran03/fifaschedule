class StandingEntity {
  final int position;
  final String teamName;
  final String teamCrest;
  final int points;
  final int playedGames;
  final int won;
  final int draw;
  final int lost;
  final int goalDifference;

  StandingEntity({
    required this.position,
    required this.teamName,
    required this.teamCrest,
    required this.points,
    required this.playedGames,
    required this.won,
    required this.draw,
    required this.lost,
    required this.goalDifference,
  });
}