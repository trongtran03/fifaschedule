class MatchEntity {
  final int id;
  final String competitionName;
  final String homeTeamName;
  final String awayTeamName;
  final String homeTeamCrest;
  final String awayTeamCrest;
  final String status;
  final String utcDate;
  final int? homeScore;
  final int? awayScore;
  final String competitionCode;

  MatchEntity({
    required this.id,
    required this.competitionName,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeTeamCrest,
    required this.awayTeamCrest,
    required this.status,
    required this.utcDate,
    this.homeScore,
    this.awayScore,
    required this.competitionCode,
  });
}