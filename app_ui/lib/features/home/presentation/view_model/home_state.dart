import 'package:equatable/equatable.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';
import 'package:fekra_house/features/documents/domain/entities/document_file.dart';
import 'package:fekra_house/features/documents/domain/entities/project_summary.dart';
import 'package:fekra_house/features/documents/domain/entities/storage_usage.dart';

enum HomeStatus { loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final User? user;
  final ProjectSummary? featuredProject;
  final List<DocumentFile> recentFiles;
  final StorageUsage? vaultUsage;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.loading,
    this.user,
    this.featuredProject,
    this.recentFiles = const [],
    this.vaultUsage,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    User? user,
    ProjectSummary? featuredProject,
    List<DocumentFile>? recentFiles,
    StorageUsage? vaultUsage,
    String? errorMessage,
  }) =>
      HomeState(
        status: status ?? this.status,
        user: user ?? this.user,
        featuredProject: featuredProject ?? this.featuredProject,
        recentFiles: recentFiles ?? this.recentFiles,
        vaultUsage: vaultUsage ?? this.vaultUsage,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, user, featuredProject, recentFiles, vaultUsage, errorMessage];
}
