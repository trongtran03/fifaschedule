import 'package:fifaschedule/domain/entities/standing_entity.dart';
import 'package:fifaschedule/presentation/blocs/standings/standings_bloc.dart';
import 'package:fifaschedule/presentation/blocs/standings/standings_event.dart';
import 'package:fifaschedule/presentation/blocs/standings/standings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key});

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late StandingsBloc _standingsBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _standingsBloc = context.read<StandingsBloc>()..add(FetchStandings());
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _standingsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('League Standings'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: SizedBox(
                  height: 50,
                  child: Image.network(
                    'https://crests.football-data.org/PL.png',
                  ),
                ),
              ),
              Tab(
                icon: SizedBox(
                  height: 30,
                  child: Image.network(
                    'https://crests.football-data.org/laliga.png',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<StandingsBloc, StandingsState>(
          builder: (context, state) {
            if (state is StandingsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StandingsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          () => context.read<StandingsBloc>().add(
                            FetchStandings(),
                          ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is StandingsEmpty) {
              return const Center(child: Text('No standings data available'));
            } else if (state is StandingsLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  _buildStandingsList(
                    context,
                    state.premierLeagueTable,
                    'No Premier League standings available',
                  ),
                  _buildStandingsList(
                    context,
                    state.laLigaTable,
                    'No La Liga standings available',
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildStandingsList(
    BuildContext context,
    List<StandingEntity> teams,
    String emptyMessage,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<StandingsBloc>().add(FetchStandings());
      },
      child:
          teams.isEmpty
              ? Center(child: Text(emptyMessage))
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(team.teamCrest),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      title: Text(
                        '${team.position}. ${team.teamName}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'P: ${team.points} | G: ${team.playedGames} | W: ${team.won} | D: ${team.draw} | L: ${team.lost} | GD: ${team.goalDifference}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
