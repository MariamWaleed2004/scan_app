import 'package:equatable/equatable.dart';
import 'package:fekra_house/features/documents/domain/entities/storage_usage.dart';
import '../../domain/entities/folder.dart';

enum FoldersStatus { loading, success, empty, failure }

class FoldersState extends Equatable {
  final FoldersStatus status;
  final List<Folder> folders;
  final StorageUsage? cloudUsage;
  final String? errorMessage;

  const FoldersState({
    this.status = FoldersStatus.loading,
    this.folders = const [],
    this.cloudUsage,
    this.errorMessage,
  });

  int get totalFiles => folders.fold<int>(0, (sum, f) => sum + f.fileCount);

  FoldersState copyWith({
    FoldersStatus? status,
    List<Folder>? folders,
    StorageUsage? cloudUsage,
    String? errorMessage,
  }) =>
      FoldersState(
        status: status ?? this.status,
        folders: folders ?? this.folders,
        cloudUsage: cloudUsage ?? this.cloudUsage,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, folders, cloudUsage, errorMessage];
}
