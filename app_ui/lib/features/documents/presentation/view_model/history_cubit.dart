import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../../domain/use_cases/get_history.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory _getHistory;
  HistoryCubit(this._getHistory) : super(const HistoryState());

  Future<void> load() async {
    emit(state.copyWith(status: HistoryStatus.loading));
    final result = await _getHistory(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: HistoryStatus.failure, errorMessage: failure.message)),
      (groups) {
        final hasFiles = groups.any((g) => g.files.isNotEmpty);
        emit(state.copyWith(status: hasFiles ? HistoryStatus.success : HistoryStatus.empty, groups: groups));
      },
    );
  }
}
