import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fekra_house/core/errors/failures.dart';
import 'package:fekra_house/core/use_case/use_case.dart';
import 'package:fekra_house/features/auth/domain/use_cases/get_current_user.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_featured_project.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_recent_files.dart';
import 'package:fekra_house/features/documents/domain/use_cases/get_vault_usage.dart';
import 'home_state.dart';

/// Home composes use cases owned by other features (auth, documents);
/// it never touches their data sources directly.
class HomeCubit extends Cubit<HomeState> {
  final GetCurrentUser _getCurrentUser;
  final GetFeaturedProject _getFeaturedProject;
  final GetRecentFiles _getRecentFiles;
  final GetVaultUsage _getVaultUsage;

  HomeCubit({
    required GetCurrentUser getCurrentUser,
    required GetFeaturedProject getFeaturedProject,
    required GetRecentFiles getRecentFiles,
    required GetVaultUsage getVaultUsage,
  })  : _getCurrentUser = getCurrentUser,
        _getFeaturedProject = getFeaturedProject,
        _getRecentFiles = getRecentFiles,
        _getVaultUsage = getVaultUsage,
        super(const HomeState());

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading));

    const none = NoParams();
    final (user, project, recent, vault) = await (
      _getCurrentUser(none),
      _getFeaturedProject(none),
      _getRecentFiles(none),
      _getVaultUsage(none),
    ).wait;

    final failure =
        [user, project, recent, vault].map((r) => r.fold((f) => f, (_) => null)).whereType<Failure>().firstOrNull;
    if (failure != null) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: failure.message));
      return;
    }

    emit(state.copyWith(
      status: HomeStatus.success,
      user: user.fold((_) => null, (v) => v),
      featuredProject: project.fold((_) => null, (v) => v),
      recentFiles: recent.getOrElse(() => const []),
      vaultUsage: vault.fold((_) => null, (v) => v),
    ));
  }
}
