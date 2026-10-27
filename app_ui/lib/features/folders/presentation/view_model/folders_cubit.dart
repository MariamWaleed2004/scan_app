import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_cloud_usage.dart';
import '../../domain/use_cases/get_folders.dart';
import 'folders_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  final GetFolders _getFolders;
  final GetCloudUsage _getCloudUsage;

  FoldersCubit({required GetFolders getFolders, required GetCloudUsage getCloudUsage})
      : _getFolders = getFolders,
        _getCloudUsage = getCloudUsage,
        super(const FoldersState());

  Future<void> load() async {
    emit(state.copyWith(status: FoldersStatus.loading));

    final (folders, cloud) = await (_getFolders(const NoParams()), _getCloudUsage(const NoParams())).wait;

    final failure = [folders, cloud].map((r) => r.fold((f) => f, (_) => null)).whereType<Failure>().firstOrNull;
    if (failure != null) {
      emit(state.copyWith(status: FoldersStatus.failure, errorMessage: failure.message));
      return;
    }

    final list = folders.getOrElse(() => const []);
    emit(state.copyWith(
      status: list.isEmpty ? FoldersStatus.empty : FoldersStatus.success,
      folders: list,
      cloudUsage: cloud.fold((_) => null, (usage) => usage),
    ));
  }
}
