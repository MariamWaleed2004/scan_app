import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/services/files/file_opener.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import '../../domain/entities/document_file.dart';
import '../../domain/use_cases/get_history.dart';
import '../../domain/use_cases/watch_document_changes.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory _getHistory;
  final FileOpener _fileOpener;
  late final StreamSubscription<void> _changesSubscription;

  HistoryCubit({
    required GetHistory getHistory,
    required WatchDocumentChanges watchDocumentChanges,
    required FileOpener fileOpener,
  })  : _getHistory = getHistory,
        _fileOpener = fileOpener,
        super(const HistoryState()) {
    // A new scan was saved → refresh quietly, without the full-screen loader.
    _changesSubscription = watchDocumentChanges().listen((_) => load(showLoading: false));
  }

  Future<void> load({bool showLoading = true}) async {
    if (showLoading) emit(state.copyWith(status: HistoryStatus.loading));
    final result = await _getHistory(const NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: HistoryStatus.failure, errorMessage: failure.message)),
      (groups) {
        final hasFiles = groups.any((g) => g.files.isNotEmpty);
        emit(state.copyWith(status: hasFiles ? HistoryStatus.success : HistoryStatus.empty, groups: groups));
      },
    );
  }

  /// Opens the document's file in the device viewer. Returns false if it can't be opened.
  Future<bool> openDocument(DocumentFile document) async {
    final path = document.filePath;
    if (path == null) return false;
    return _fileOpener.open(path);
  }

  @override
  Future<void> close() async {
    await _changesSubscription.cancel();
    return super.close();
  }
}
