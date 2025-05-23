import 'package:fifaschedule/data/data_sources/match_remote_data_source.dart';
import 'package:fifaschedule/data/data_sources/standings_remote_data_source.dart';
import 'package:fifaschedule/data/repositories/match_repository_impl.dart';
import 'package:fifaschedule/data/repositories/standings_repository_impl.dart';
import 'package:fifaschedule/domain/use_cases/get_matches_use_case.dart';
import 'package:fifaschedule/domain/use_cases/get_standings_use_case.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_bloc.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_event.dart';
import 'package:fifaschedule/presentation/blocs/standings/standings_bloc.dart';
import 'package:fifaschedule/presentation/screens/home_screen.dart';
import 'package:fifaschedule/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user = FirebaseAuth.instance.currentUser;
  runApp(FootballApp(isLoggedIn: user != null));
}

class FootballApp extends StatelessWidget {
  final bool isLoggedIn;
  const FootballApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MatchBloc(
            GetMatchesUseCase(MatchRepositoryImpl(MatchRemoteDataSource())),
          )..add(FetchMatches()),
        ),
        BlocProvider(
          create: (context) => StandingsBloc(
            GetStandingsUseCase(StandingsRepositoryImpl(StandingsRemoteDataSource())),
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
        home: isLoggedIn ? const HomeScreen() :  LoginScreen(),
      ),
    );
  }
}
