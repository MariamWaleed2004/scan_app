import 'package:equatable/equatable.dart';

class ProjectSummary extends Equatable {
  final String name;
  final int blueprintCount;
  final String syncedLabel;
  final List<String> memberInitials;

  const ProjectSummary({
    required this.name,
    required this.blueprintCount,
    required this.syncedLabel,
    required this.memberInitials,
  });

  @override
  List<Object?> get props => [name, blueprintCount, syncedLabel, memberInitials];
}
