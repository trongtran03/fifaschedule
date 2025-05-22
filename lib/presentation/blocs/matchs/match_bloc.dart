
import 'package:fifaschedule/domain/use_cases/get_matches_use_case.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_event.dart';
import 'package:fifaschedule/presentation/blocs/matchs/match_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final GetMatchesUseCase getMatchesUseCase;

  MatchBloc(this.getMatchesUseCase) : super(MatchesInitial()) {
    on<FetchMatches>(_onFetchMatches);
  }

  Future<void> _onFetchMatches(FetchMatches event, Emitter<MatchState> emit) async {
    emit(MatchesLoading());

    try {
      final allMatches = await getMatchesUseCase('2025-05-15', '2025-05-25');
      final premierLeagueMatches = allMatches.where((match) => match.competitionCode == 'PL').toList();
      final laLigaMatches = allMatches.where((match) => match.competitionCode == 'PD').toList();

      if (allMatches.isEmpty) {
        emit(MatchesEmpty());
      } else {
        emit(MatchesLoaded(
          allMatches: allMatches,
          premierLeagueMatches: premierLeagueMatches,
          laLigaMatches: laLigaMatches,
        ));
      }
    } catch (e) {
      emit(MatchesError('Error: $e'));
    }
  }
}