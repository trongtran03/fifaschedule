
import 'package:fifaschedule/domain/use_cases/get_standings_use_case.dart';
import 'package:fifaschedule/presentation/blocs/standings/standings_event.dart';
import 'package:fifaschedule/presentation/blocs/standings/standings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StandingsBloc extends Bloc<StandingsEvent, StandingsState> {
  final GetStandingsUseCase getStandingsUseCase;

  StandingsBloc(this.getStandingsUseCase) : super(StandingsInitial()) {
    on<FetchStandings>(_onFetchStandings);
  }

  Future<void> _onFetchStandings(FetchStandings event, Emitter<StandingsState> emit) async {
    emit(StandingsLoading());

    try {
      final standings = await getStandingsUseCase();
      final plTable = standings['premierLeague']!;
      final llTable = standings['laLiga']!;

      if (plTable.isEmpty && llTable.isEmpty) {
        emit(StandingsEmpty());
      } else {
        emit(StandingsLoaded(
          premierLeagueTable: plTable,
          laLigaTable: llTable,
        ));
      }
    } catch (e) {
      emit(StandingsError('Error: $e'));
    }
  }
}