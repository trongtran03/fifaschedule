
import 'package:fifaschedule/domain/entities/match_entity.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_bloc.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_event.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MatchesScreen extends StatelessWidget {
  final String filter; // 'all', 'PL', or 'PD'

  const MatchesScreen({super.key, required this.filter});

  String formatDate(String utcDate) {
    final dateTime = DateTime.parse(utcDate);
    return DateFormat('MMM d, yyyy - HH:mm').format(dateTime.toLocal());
  }

  String getMatchScore(MatchEntity match) {
    if (match.homeScore == null || match.awayScore == null) {
      return '-';
    }
    return '${match.homeScore} - ${match.awayScore}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MatchesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<MatchBloc>().add(FetchMatches()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is MatchesEmpty) {
          return const Center(child: Text('No matches found'));
        } else if (state is MatchesLoaded) {
          final matches = filter == 'PL'
              ? state.premierLeagueMatches
              : filter == 'PD'
                  ? state.laLigaMatches
                  : state.allMatches;

          if (matches.isEmpty) {
            return Center(child: Text('No ${filter == 'PL' ? 'Premier League' : filter == 'PD' ? 'La Liga' : 'matches'} found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<MatchBloc>().add(FetchMatches());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index] as MatchEntity;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  match.competitionName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Text(
                                formatDate(match.utcDate),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(match.homeTeamCrest),
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      match.homeTeamName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  getMatchScore(match),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(match.awayTeamCrest),
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      match.awayTeamName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Status: ${match.status}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}