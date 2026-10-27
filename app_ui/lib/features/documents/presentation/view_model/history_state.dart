import 'package:equatable/equatable.dart';
import '../../domain/entities/document_file.dart';
import '../../domain/entities/history_group.dart';

enum HistoryStatus { loading, success, empty, failure }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final List<HistoryGroup> groups;
  final String? errorMessage;

  const HistoryState({this.status = HistoryStatus.loading, this.groups = const [], this.errorMessage});

  List<DocumentFile> get files => groups.expand((g) => g.files).toList();
  double get totalMb => files.fold<double>(0, (sum, f) => sum + f.sizeMb);
  int get projectCount => files.map((f) => f.category).toSet().length;

  HistoryState copyWith({HistoryStatus? status, List<HistoryGroup>? groups, String? errorMessage}) => HistoryState(
        status: status ?? this.status,
        groups: groups ?? this.groups,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, groups, errorMessage];
}
