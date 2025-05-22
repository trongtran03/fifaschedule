import 'package:fifaschedule/data/data_sources/match_remote_data_source.dart';
import 'package:fifaschedule/data/data_sources/standings_remote_data_source.dart';
import 'package:fifaschedule/data/repositories/match_repository_impl.dart';
import 'package:fifaschedule/data/repositories/standings_repository_impl.dart';
import 'package:fifaschedule/domain/use_cases/get_matches_use_case.dart';
import 'package:fifaschedule/domain/use_cases/get_standings_use_case.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_bloc.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_event.dart';
import 'package:fifaschedule/presentation/blocs/standings/standings_bloc.dart';
import 'package:fifaschedule/presentation/screens/matches_screen.dart';
import 'package:fifaschedule/presentation/screens/standings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//test commit git
void main() {
  runApp(const FootballApp());
}

class FootballApp extends StatelessWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => MatchBloc(
                GetMatchesUseCase(MatchRepositoryImpl(MatchRemoteDataSource())),
              )..add(FetchMatches()),
        ),
        BlocProvider(
          create:
              (context) => StandingsBloc(
                GetStandingsUseCase(
                  StandingsRepositoryImpl(StandingsRemoteDataSource()),
                ),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Football App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logofifa.png', height: 40),
            // Image.network('https://crests.football-data.org/laliga.png',height: 40,),
            const Text(
              "schedule",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard_rounded,size: 30,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StandingsScreen(),
                ),
              );
            },
            tooltip: 'View Standings',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: SizedBox(
                height: 50,
                child: Image.asset('assets/images/uefa.png'),
              ),
            ),
            Tab(
              icon: SizedBox(
                height: 50,
                child: Image.network('https://crests.football-data.org/PL.png'),
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
            Tab(
              icon: SizedBox(
                height: 50,
                child: Image.network(
                  'https://crests.football-data.org/BL1.png',
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MatchesScreen(filter: 'all'),
          MatchesScreen(filter: 'PL'),
          MatchesScreen(filter: 'PD'),
          MatchesScreen(filter: 'FL1'),
        ],
      ),
    );
  }
}
